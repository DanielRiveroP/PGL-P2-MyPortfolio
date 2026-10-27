import 'package:flutter/material.dart';
import 'package:pglp2myportfolio/components/hobbies_view.dart'; // <-- Import necesario para el footer
import 'package:pglp2myportfolio/components/hobby_card.dart'; // <-- Import necesario para el footer
import 'package:pglp2myportfolio/components/portfolio_footer.dart'; // <-- Import necesario para el footer
import 'package:pglp2myportfolio/components/portfolio_header.dart'; // <-- Import necesario para el footer

int opcionBody = 0;
List<String> hobbies = [
  'Escuchar musica',
  'Senderismo',
  'Estudiar economía',
  "Videojuegos",
  "Juegos de mesa con amigos",
  "Jugar baloncesto",
  "Gimnasio",
  "Hobbie2",
];

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Daniel Rivero's Portfolio"),
          backgroundColor: Colors.black12,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              ProfileSubHeader(opcionBody: opcionBody),
              const Divider(height: 1),
              Expanded(
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  // Quitamos el 'const' de aquí porque opcionBody cambia
                  child: HobbiesView(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomFooter(
          onTabChanged: (nuevaOpcion) {
            setState(() {
              opcionBody = nuevaOpcion;
            });
          },
        ),
      ),
    );
  }
}