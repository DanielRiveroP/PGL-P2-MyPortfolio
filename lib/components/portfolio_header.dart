import 'package:flutter/material.dart';

class ProfileSubHeader extends StatelessWidget {
  final int opcionBody;

  const ProfileSubHeader({super.key, required this.opcionBody});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/prime.png"),
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Soy estudiante de un ciclo superior de DAM y me gusta mucho la programación, el senderismo y los videojuegos.",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}