import 'package:flutter/material.dart';

import '../models/guachinche.dart';
import '../widgets/app_drawer.dart';
import '../widgets/guachinche_card.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  // Lista dinámica de guachinches y contador
  final List<Guachinche> _guachinches = [];
  int _contadorId = 1;

  // Controladores para el formulario del Modal
  final _nombreController = TextEditingController();
  final _islaController = TextEditingController();
  final _especialidadController = TextEditingController();

  // Variable para la categoría seleccionada por defecto
  String _categoriaSeleccionada = 'Tradicional';

  void _mostrarModalAgregar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(
            0xFF1B3B1A,
          ), // Fondo verde oscuro corporativo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Añadir Guachinche',
            style: TextStyle(
              color: Color(0xFFE6D7C3),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo Nombre
                TextField(
                  controller: _nombreController,
                  style: const TextStyle(color: Color(0xFFE6D7C3)),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: const TextStyle(color: Color(0xFFE6D7C3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE6D7C3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFE6D7C3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Campo Isla
                TextField(
                  controller: _islaController,
                  style: const TextStyle(color: Color(0xFFE6D7C3)),
                  decoration: InputDecoration(
                    labelText: 'Isla (ej. Tenerife)',
                    labelStyle: const TextStyle(color: Color(0xFFE6D7C3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE6D7C3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFE6D7C3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Campo Especialidad
                TextField(
                  controller: _especialidadController,
                  style: const TextStyle(color: Color(0xFFE6D7C3)),
                  decoration: InputDecoration(
                    labelText: 'Especialidad (ej. Carne cabra)',
                    labelStyle: const TextStyle(color: Color(0xFFE6D7C3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE6D7C3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFE6D7C3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Selector de Categoría corregido para evitar el error de nulos
                DropdownButtonFormField<String?>(
                  value: _categoriaSeleccionada,
                  dropdownColor: const Color(0xFF1B3B1A),
                  style: const TextStyle(color: Color(0xFFE6D7C3)),
                  items: ['Tradicional', 'Parrilla', 'Vino Propio'].map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Text(
                        cat,
                        style: const TextStyle(color: Color(0xFFE6D7C3)),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _categoriaSeleccionada =
                          val ??
                          'Tradicional'; // Si viene null, asigna por defecto
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    labelStyle: const TextStyle(color: Color(0xFFE6D7C3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE6D7C3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFE6D7C3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFFE6D7C3)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B1A),
                foregroundColor: const Color(0xFFE6D7C3),
                side: const BorderSide(color: Color(0xFFE6D7C3)),
              ),
              onPressed: () {
                if (_nombreController.text.isNotEmpty) {
                  setState(() {
                    _guachinches.add(
                      Guachinche(
                        id: _contadorId++,
                        nombre: _nombreController.text,
                        isla: _islaController.text,
                        especialidad: _especialidadController.text,
                        categoria: _categoriaSeleccionada, // <--- ¡AQUÍ ESTÁ LA CATEGORÍA AÑADIDA!
                      ),
                    );
                  });
                  _nombreController.clear();
                  _islaController.clear();
                  _especialidadController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Guardar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // Función para el modal de confirmación de Borrar Todo
  void _mostrarModalConfirmacionBorrarTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Borrar todo'),
          content: const Text(
            '¿Estás seguro de que quieres eliminar todos los guachinches?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _guachinches.clear();
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Sí, borrar todo',
                style: TextStyle(color: Color(0xFFE6D7C3)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B3B1A),
      appBar: AppBar(
        title: const Text('Gestión Guachinches'),
        backgroundColor: const Color(0xFF1B3B1A),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Marcador superior y botón de Borrar todo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total guachinches: ${_guachinches.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6D7C3),
                  ),
                ),
                _guachinches.isEmpty
                    ? const SizedBox.shrink()
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _mostrarModalConfirmacionBorrarTodo,
                        icon: const Icon(Icons.delete_sweep, size: 18),
                        label: const Text('Borrar todo'),
                      ),
              ],
            ),
          ),
          // Lista dinámica
          Expanded(
            child: _guachinches.isEmpty
                ? const Center(
                    child: Text(
                      'No hay guachinches registrados.\n¡Añade uno abajo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFE6D7C3), fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _guachinches.length,
                    itemBuilder: (context, index) {
                      final guachinche = _guachinches[index];
                      return GuachincheCard(
                        guachinche: guachinche,
                        onDelete: () {
                          setState(() {
                            _guachinches.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      // Botón flotante inferior para añadir guachinche
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarModalAgregar,
        backgroundColor: const Color(0xFF1B3B1A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Añadir Guachinche',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE6D7C3),
          ),
        ),
      ),
    );
  }
}
