import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_services.dart';
import '../widgets/alerta_registro.dart';
import '../widgets/formulario_registro.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color verdeCorporativo = Color(0xFF1B3B1A);
  static const Color colorArena = Color(0xFFE6D7C3);

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _cargando = false;

  @override
  void dispose() {
    _nombreController.dispose();
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

  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    final nombre = _nombreController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      final resultado = await _authService.registrarConMensaje(
        nombre: nombre,
        email: email,
        password: password,
      );

      if (!mounted) return;
      await _mostrarAlerta(
        titulo: resultado.ok ? 'Registro exitoso' : 'Error en el registro',
        mensaje: resultado.mensaje,
        onAceptar: () {
          if (resultado.ok) {
            context.go('/login');
          }
        },
      );
    } catch (e) {
      if (!mounted) return;
      await _mostrarAlerta(
        titulo: 'Error en el registro',
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
        iconTheme: const IconThemeData(color: colorArena),
        title: const Text(
          'Registro de Usuario',
          style: TextStyle(color: colorArena, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: FormularioRegistro(
              formKey: _formKey,
              nombreController: _nombreController,
              emailController: _emailController,
              passwordController: _passwordController,
              cargando: _cargando,
              onRegistrar: _registrarUsuario,
              verdeCorporativo: verdeCorporativo,
              colorArena: colorArena,
            ),
          ),
        ),
      ),
    );
  }
}