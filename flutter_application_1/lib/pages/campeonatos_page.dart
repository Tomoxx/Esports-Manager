import 'package:flutter/material.dart';

class CampeonatoPage extends StatelessWidget {
  const CampeonatoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campeonato'),
      ),
      body: Center(
        child: Text('Contenido de la página del Campeonato'),
      ),
    );
  }
}
