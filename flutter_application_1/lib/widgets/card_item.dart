import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String imagePath; 
  const CardItem({
    required this.title,
    required this.onTap,
    required this.imagePath, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        color: Colors.white,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
