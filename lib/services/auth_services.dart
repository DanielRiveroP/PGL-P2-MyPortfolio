import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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

  // Login: envía email y contraseña, y si va bien guarda el token
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      if (token != null) {
        await guardarToken(token);
        return true;
      }
    }
    return false;
  }

  // 3. Comprobar si el token guardado sigue siendo válido en la API
  Future<bool> comprobarTokenValido() async {
    final token = await leerToken();
    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/verify'),
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

  Future<String> obtenerMensajeBienvenida() async {
    final token = await leerToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/welcome'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );

    final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data['message']?.toString() ?? response.body;
    } else {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'Error (${response.statusCode}) al obtener la bienvenida.';
    }
  }
}