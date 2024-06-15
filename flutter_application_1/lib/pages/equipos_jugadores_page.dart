import 'package:flutter/material.dart';

class EquiposJugadoresPage extends StatefulWidget {
  const EquiposJugadoresPage({Key? key}) : super(key: key);

  @override
  _EquiposJugadoresPageState createState() => _EquiposJugadoresPageState();
}

class _EquiposJugadoresPageState extends State<EquiposJugadoresPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Contenido de la página de Equipos'),
    Text('Contenido de la página de Jugadores'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos y Jugadores'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Equipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Jugadores',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
