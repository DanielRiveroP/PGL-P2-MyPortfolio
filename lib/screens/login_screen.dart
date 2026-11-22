import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/alerta_registro.dart';
import '../widgets/formulario_login.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color verdeCorporativo = Color(0xFF1B3B1A);
  static const Color colorArena = Color(0xFFE6D7C3);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _revisarSesion();
  }

  Future<void> _revisarSesion() async {
    final esValido = await _authService.comprobarTokenValido();
    if (!mounted) return;

    if (esValido) {
      context.go('/');
    }
  }

  bool _cargando = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _mostrarAlerta({
    required String titulo,
    required String mensaje,
    required VoidCallback onAceptar,
  }) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertaRegistro(
          titulo: titulo,
          mensaje: mensaje,
          verdeCorporativo: verdeCorporativo,
          colorArena: colorArena,
          onAceptar: () {
            Navigator.pop(context);
            onAceptar();
          },
        );
      },
    );
  }

  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      // TODO: Llamada a la API de login con `email` y `password`,
      // guardar token de forma segura y redirigir a bienvenida/inicio.
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      await _mostrarAlerta(
        titulo: 'Inicio de sesión',
        mensaje: 'Respuesta para $email (pendiente conectar servicio HTTP).',
        onAceptar: () {
          // Cuando tengas el token válido, redirigirás a la pantalla de bienvenida
        },
      );
    } catch (e) {
      if (!mounted) return;
      await _mostrarAlerta(
        titulo: 'Error al iniciar sesión',
        mensaje: 'Respuesta de error: $e',
        onAceptar: () {},
      );
    } finally {
      if (mounted) {
        setState(() => _cargando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeCorporativo,
      appBar: AppBar(
        backgroundColor: verdeCorporativo,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Iniciar Sesión',
          style: TextStyle(color: colorArena, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sabores Canarios',
                  style: TextStyle(
                    color: colorArena,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Accede con tu cuenta',
                  style: TextStyle(color: colorArena, fontSize: 15),
                ),
                const SizedBox(height: 28),
                FormularioLogin(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  cargando: _cargando,
                  onLogin: _iniciarSesion,
                  onIrARegistro: () {
                    context.push('/register');
                  },
                  verdeCorporativo: verdeCorporativo,
                  colorArena: colorArena,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}