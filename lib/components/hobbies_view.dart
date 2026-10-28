import 'package:flutter/material.dart';
import '../screens/portfolio_screen.dart';
import 'hobby_card.dart';

class HobbiesView extends StatelessWidget {
  const HobbiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            CosaRandom(hobbie: hobbies[0]),
            const SizedBox(height: 12),
            CosaRandom(hobbie: hobbies[1]),
            const SizedBox(height: 12),
            CosaRandom(hobbie: hobbies[2]),
            const SizedBox(height: 12),
            CosaRandom(hobbie: hobbies[5]), // Jugar baloncesto
            const SizedBox(height: 12),
            CosaRandom(hobbie: hobbies[3]),
            const SizedBox(height: 12),
            CosaRandom(hobbie: hobbies[6]), // Gimnasio
            const SizedBox(height: 12),
            const CosaRandom(hobbie: "Peliculas de mafias"),
            const SizedBox(height: 12),
            const CosaRandom(hobbie: "Conducir"),
            const SizedBox(height: 12),
            const CosaRandom(hobbie: "Hobbie2")
          ],
        ),
      ),
    );
  }
}