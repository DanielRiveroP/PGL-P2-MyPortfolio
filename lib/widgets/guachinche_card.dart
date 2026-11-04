import 'package:flutter/material.dart';
import '../models/guachinche.dart';

class GuachincheCard extends StatelessWidget {
  final Guachinche guachinche;
  final VoidCallback onDelete;

  const GuachincheCard({
    super.key,
    required this.guachinche,
    required this.onDelete,
  });

  // Tu función de iconos dentro del propio widget
  Widget _obtenerImagenPorCategoria(String categoria) {
    IconData icono;
    Color color;

    if (categoria == 'Tradicional') {
      icono = Icons.restaurant;
      color = Colors.amber;
    } else if (categoria == 'Parrilla') {
      icono = Icons.local_fire_department;
      color = Colors.deepOrange;
    } else {
      icono = Icons.wine_bar;
      color = Colors.purple;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icono, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 40, 66, 39),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: _obtenerImagenPorCategoria(guachinche.categoria),
        title: Text(
          guachinche.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE6D7C3)),
        ),
        subtitle: Text(
          'Isla: ${guachinche.isla}\nEspecialidad: ${guachinche.especialidad} [${guachinche.categoria}]',
          style: const TextStyle(color: Color(0xFFE6D7C3)),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete, // Llama a la función de borrar que le pases
        ),
      ),
    );
  }
}