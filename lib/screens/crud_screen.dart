import 'package:flutter/material.dart';
import '../models/guachinche.dart';
import '../widgets/app_drawer.dart';

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

  // Función para mostrar el modal de añadir guachinche
  void _mostrarModalAgregar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir Guachinche'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _islaController,
                  decoration: const InputDecoration(labelText: 'Isla (ej. Tenerife)'),
                ),
                TextField(
                  controller: _especialidadController,
                  decoration: const InputDecoration(labelText: 'Especialidad (ej. Carne cabra)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B1A),
                foregroundColor: Colors.white,
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
                      ),
                    );
                  });
                  _nombreController.clear();
                  _islaController.clear();
                  _especialidadController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
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
          content: const Text('¿Estás seguro de que quieres eliminar todos los guachinches?'),
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
              child: const Text('Sí, borrar todo', style: TextStyle(color: Color(0xFFE6D7C3))),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFE6D7C3)),
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
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B3B1A).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.restaurant, color: Color(0xFF1B3B1A)),
                          ),
                          title: Text(
                            guachinche.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE6D7C3)),
                          ),
                          subtitle: Text('Isla: ${guachinche.isla}\nEspecialidad: ${guachinche.especialidad}'),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _guachinches.removeAt(index);
                              });
                            },
                          ),
                        ),
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE6D7C3)),
        
        ),
      ),
    );
  }
}