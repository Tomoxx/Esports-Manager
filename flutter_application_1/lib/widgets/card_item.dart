import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  CardItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64.0), // Display the icon
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
