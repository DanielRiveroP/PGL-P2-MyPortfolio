import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // <--- Importante para usar context.go

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2E7D32)),
            child: Text(
              'Sabores Canarios',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Bienvenida'),
            onTap: () {
              Navigator.pop(context); // Cierra el menú
              context.go('/');        // Navega con go_router a inicio
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Portfolio'),
            onTap: () {
              Navigator.pop(context); // Cierra el menú
              context.go('/portfolio'); // Navega con go_router al portfolio
            },
          ),
        ],
      ),
    );
  }
}