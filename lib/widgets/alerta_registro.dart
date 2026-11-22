import 'package:flutter/material.dart';

class AlertaRegistro extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final VoidCallback onAceptar;
  final Color verdeCorporativo;
  final Color colorArena;

  const AlertaRegistro({
    super.key,
    required this.titulo,
    required this.mensaje,
    required this.onAceptar,
    this.verdeCorporativo = const Color(0xFF1B3B1A),
    this.colorArena = const Color(0xFFE6D7C3),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: verdeCorporativo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorArena, width: 0.8),
      ),
      title: Text(
        titulo,
        style: TextStyle(color: colorArena, fontWeight: FontWeight.bold),
      ),
      content: Text(
        mensaje,
        style: TextStyle(color: colorArena),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorArena,
            foregroundColor: verdeCorporativo,
          ),
          onPressed: onAceptar,
          child: const Text(
            'Aceptar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}