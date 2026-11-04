import 'package:flutter/material.dart';
import '../models/coche.dart';
import '../widgets/app_drawer.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  // Lista dinámica de elementos
  final List<Coche> _coches = [];
  int _contadorId = 1;

  // Controladores para el formulario del Modal
  final _marcaController = TextEditingController();
  final _descController = TextEditingController();
  String _categoriaSeleccionada = 'Deportivo'; // Categoría por defecto

  // Función para mostrar el modal (Dialog) de añadir coche (Requisito 4 y 5)
  void _mostrarModalAgregar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir Nuevo Coche'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _marcaController,
                  decoration: const InputDecoration(labelText: 'Marca / Nombre'),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Descripción breve'),
                ),
                const SizedBox(height: 16),
                // Selector de categoría (Requisito 5)
                DropdownButtonFormField<String>(
                  value: _categoriaSeleccionada,
                  items: ['Deportivo', 'SUV', 'Clásico'].map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _categoriaSeleccionada = val!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Categoría'),
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
              onPressed: () {
                if (_marcaController.text.isNotEmpty) {
                  setState(() {
                    _coches.add(
                      Coche(
                        id: _contadorId++,
                        marca: _marcaController.text,
                        descripcion: _descController.text,
                        categoria: _categoriaSeleccionada,
                      ),
                    );
                  });
                  _marcaController.clear();
                  _descController.clear();
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

  // Función auxiliar para retornar una imagen según la categoría (Requisito 6)
  Widget _obtenerImagenPorCategoria(String categoria) {
    IconData icono;
    Color color;
    if (categoria == 'Deportivo') {
      icono = Icons.speed;
      color = Colors.red;
    } else if (categoria == 'SUV') {
      icono = Icons.directions_car;
      color = Colors.green;
    } else {
      icono = Icons.history;
      color = Colors.amber;
    }
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icono, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD de Coches'),
        backgroundColor: const Color(0xFF1B3B1A),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: const AppDrawer(), // Requisito 2: Añadido al Drawer
      body: Column(
        children: [
          // Requisito 8: Marcador que indica el número total de elementos
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black12,
            width: double.infinity,
            child: Text(
              'Total de coches registrados: ${_coches.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: _coches.isEmpty
                ? const Center(child: Text('No hay coches. ¡Añade uno!'))
                : ListView.builder(
                    itemCount: _coches.length,
                    itemBuilder: (context, index) {
                      final coche = _coches[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          // Requisito 6: Imagen o icono al lado según la categoría
                          leading: _obtenerImagenPorCategoria(coche.categoria),
                          title: Text(coche.marca, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${coche.descripcion}\nCategoría: ${coche.categoria}'),
                          isThreeLine: true,
                          // Requisito 7: Botón para ser borrado individualmente
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _coches.removeAt(index);
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
      // Botón flotante para abrir el modal de añadir
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarModalAgregar,
        backgroundColor: const Color(0xFF1B3B1A),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}