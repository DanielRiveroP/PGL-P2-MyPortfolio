import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  final ValueChanged<int> onTabChanged;

  const CustomFooter({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => onTabChanged(0),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
              foregroundColor: Colors.white,
            ),
            child: const Text("Mis hobbies"),
          ),
          ElevatedButton(
            onPressed: () => onTabChanged(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
              foregroundColor: Colors.white,
            ),
            child: const Text("My repositorio"),
          ),
        ],
      ),
    );
  }
}