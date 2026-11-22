import 'package:flutter/material.dart';
import 'campo_registro.dart';

class FormularioRegistro extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nombreController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool cargando;
  final VoidCallback onRegistrar;
  final Color verdeCorporativo;
  final Color colorArena;

  const FormularioRegistro({
    super.key,
    required this.formKey,
    required this.nombreController,
    required this.emailController,
    required this.passwordController,
    required this.cargando,
    required this.onRegistrar,
    this.verdeCorporativo = const Color(0xFF1B3B1A),
    this.colorArena = const Color(0xFFE6D7C3),
  });

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  bool _ocultarPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CampoRegistro(
            controller: widget.nombreController,
            label: 'Nombre completo',
            icon: Icons.person_outline,
            colorArena: widget.colorArena,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Introduce tu nombre completo';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CampoRegistro(
            controller: widget.emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            colorArena: widget.colorArena,
            validator: (value) {
              final texto = value?.trim() ?? '';
              if (texto.isEmpty) return 'Introduce tu email';
              if (!texto.contains('@') || !texto.contains('.')) {
                return 'Introduce un email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CampoRegistro(
            controller: widget.passwordController,
            label: 'Contraseña',
            icon: Icons.lock_outline,
            obscureText: _ocultarPassword,
            colorArena: widget.colorArena,
            suffixIcon: IconButton(
              icon: Icon(
                _ocultarPassword ? Icons.visibility_off : Icons.visibility,
                color: widget.colorArena,
              ),
              onPressed: () {
                setState(() => _ocultarPassword = !_ocultarPassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Introduce una contraseña';
              }
              if (value.length < 6) {
                return 'Mínimo 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.colorArena,
                foregroundColor: widget.verdeCorporativo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: widget.cargando ? null : widget.onRegistrar,
              child: widget.cargando
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: widget.verdeCorporativo,
                      ),
                    )
                  : const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}