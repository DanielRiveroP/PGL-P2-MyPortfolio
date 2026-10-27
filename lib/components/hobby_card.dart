import 'package:flutter/material.dart';

class CosaRandom extends StatelessWidget {
  final String textasion;

  const CosaRandom({super.key, required this.textasion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa todo el ancho disponible
      height: 60, // Rectángulo grande y contundente
      decoration: BoxDecoration(
        color: Colors.green[900], // Fondo oscuro elegante
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[700]!, width: 1.5),
      ),
      child: Center(
        child: Text(
          textasion,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}