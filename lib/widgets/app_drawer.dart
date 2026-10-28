import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos la ruta actual para saber qué opción marcar como seleccionada
    final String currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: const Color(0xFF1B3B1A), // Verde oscuro corporativo
      child: SafeArea(
        child: Column(
          children: [
            // 1. HEADER DEL DRAWER (Perfil de usuario)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white70,
                    child: Icon(Icons.person, size: 35, color: Colors.black87),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Mi Cuenta',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 10),

            // 2. OPCIONES DEL MENÚ
            // Nota: De momento solo funcional el Portfolio, las demás se pueden dejar preparadas
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Inicio',
              isSelected: currentPath == '/',
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                context.go('/');        // Ruta de bienvenida (si la tienes)
              },
            ),
            _buildDrawerItem(
              icon: Icons.restaurant_menu,
              title: 'Guachinches',
              isSelected: false,
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: Icons.map,
              title: 'Mapa de Islas',
              isSelected: false,
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: Icons.description,
              title: 'Portfolio',
              isSelected: currentPath == '/portfolio', // Se marca si estamos en portfolio
              onTap: () {
                Navigator.pop(context);
                context.go('/portfolio'); // Navega al portfolio
              },
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'Ajustes',
              isSelected: false,
              onTap: () => Navigator.pop(context),
            ),

            const Spacer(), // Empuja el contenido restante hacia abajo

            // 3. BOTÓN DE CERRAR SESIÓN ABAJO
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para crear cada elemento de la lista con su estilo y selección
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        // Si está seleccionado, le ponemos el fondo semitransparente redondeado como en tu imagen
        color: isSelected ? const Color(0xFF355E3B) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}