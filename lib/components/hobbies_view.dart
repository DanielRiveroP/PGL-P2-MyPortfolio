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
            CosaRandom(textasion: hobbies[0]),
            const SizedBox(height: 12),
            CosaRandom(textasion: hobbies[1]),
            const SizedBox(height: 12),
            CosaRandom(textasion: hobbies[2]),
            const SizedBox(height: 12),
            CosaRandom(textasion: hobbies[5]), // Jugar baloncesto
            const SizedBox(height: 12),
            CosaRandom(textasion: hobbies[3]),
            const SizedBox(height: 12),
            CosaRandom(textasion: hobbies[6]), // Gimnasio
            const SizedBox(height: 12),
            const CosaRandom(textasion: "Peliculas de mafias"),
            const SizedBox(height: 12),
            const CosaRandom(textasion: "Conducir"),
            const SizedBox(height: 12),
            const CosaRandom(textasion: "Hobbie2")
          ],
        ),
      ),
    );
  }
}