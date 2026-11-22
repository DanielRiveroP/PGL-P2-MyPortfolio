import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthResult {
  final bool ok;
  final String mensaje;

  const AuthResult({required this.ok, required this.mensaje});
}

class AuthService {
  static const String _baseUrl = 'https://my-users-api.onrender.com';
  static const String _claveToken = 'token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 1. Guardar el token de forma segura tras hacer login
  Future<void> guardarToken(String token) async {
    await _storage.write(key: _claveToken, value: token);
  }

  // 2. Leer el token guardado
  Future<String?> leerToken() async {
    return await _storage.read(key: _claveToken);
  }

  // Borrar el token (útil para cerrar sesión)
  Future<void> borrarToken() async {
    await _storage.delete(key: _claveToken);
  }

  // Registro de usuario: POST /users/register
  Future<AuthResult> registrarConMensaje({
    required String nombre,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': nombre,
          'email': email,
          'pwd': password,
        }),
      );

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      final mensajeApi = data is Map
          ? (data['message'] ?? data['msg'] ?? data['error'])?.toString()
          : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AuthResult(
          ok: true,
          mensaje: mensajeApi ?? 'Usuario registrado correctamente.',
        );
      }

      return AuthResult(
        ok: false,
        mensaje: mensajeApi ?? 'Error (${response.statusCode}) al registrar el usuario.',
      );
    } catch (e) {
      return AuthResult(
        ok: false,
        mensaje: 'Error de conexión al registrar: $e',
      );
    }
  }

  // Login: POST /users/login
  Future<AuthResult> loginConMensaje(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'pwd': password}),
      );

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      final mensajeApi = data is Map
          ? (data['message'] ?? data['msg'] ?? data['error'])?.toString()
          : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final token = data is Map
            ? (data['token'] ?? data['accessToken'] ?? data['access_token'])?.toString()
            : null;

        if (token != null && token.isNotEmpty) {
          await guardarToken(token);
        }

        return AuthResult(
          ok: true,
          mensaje: mensajeApi ?? 'Inicio de sesión correcto.',
        );
      }

      return AuthResult(
        ok: false,
        mensaje: mensajeApi ?? 'Credenciales incorrectas (${response.statusCode}).',
      );
    } catch (e) {
      return AuthResult(
        ok: false,
        mensaje: 'Error de conexión al iniciar sesión: $e',
      );
    }
  }

  // Login simple
  Future<bool> login(String email, String password) async {
    final res = await loginConMensaje(email, password);
    return res.ok;
  }

  // Comprobar si el token guardado sigue siendo válido: GET /users/check-token
  Future<bool> comprobarTokenValido() async {
    final token = await leerToken();
    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/check-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> cerrarSesion() async {
    await borrarToken();
  }

  // Obtener mensaje personalizado de bienvenida: GET /users/welcome
  Future<String> obtenerMensajeBienvenida() async {
    final token = await leerToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/users/welcome'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );

    final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data is Map
          ? (data['message']?.toString() ?? response.body)
          : response.body;
    } else {
      return data is Map
          ? (data['message']?.toString() ??
                data['error']?.toString() ??
                'Error (${response.statusCode}) al obtener la bienvenida.')
          : 'Error (${response.statusCode}) al obtener la bienvenida.';
    }
  }
}