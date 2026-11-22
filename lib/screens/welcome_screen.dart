import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_services.dart';
import '../widgets/app_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final AuthService _authService = AuthService();

  Future<void> _mostrarMensajeBienvenida(BuildContext context) async {
    final mensaje = await _authService.obtenerMensajeBienvenida();
    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B3B1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE6D7C3), width: 0.8),
          ),
          title: const Text(
            'Bienvenida',
            style: TextStyle(color: Color(0xFFE6D7C3), fontWeight: FontWeight.bold),
          ),
          content: Text(
            mensaje,
            style: const TextStyle(color: Color(0xFFE6D7C3)),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6D7C3),
                foregroundColor: const Color(0xFF1B3B1A),
              ),
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold)),
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
        title: const Text('Sabores Canarios'),
        backgroundColor: const Color(0xFF1B3B1A),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/SaboresCanarios.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '¡Bienvenido a\nSabores Canarios!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Descubre la esencia de nuestra gastronomía.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Botón de bienvenida de la API (Punto 5)
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B3B1A),
                          foregroundColor: const Color(0xFFE6D7C3),
                          side: const BorderSide(color: Color(0xFFE6D7C3)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () => _mostrarMensajeBienvenida(context),
                        child: const Text(
                          'Ver bienvenida de la API',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Botón "Empezar"
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6D7C3),
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          context.go('/portfolio');
                        },
                        child: const Text(
                          'Empezar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}