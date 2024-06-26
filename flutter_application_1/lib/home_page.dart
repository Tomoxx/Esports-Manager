import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/teams_page.dart';
import 'package:flutter_application_1/pages/tournaments_page.dart';
import 'package:flutter_application_1/pages/venues_page.dart';
import 'package:flutter_application_1/widgets/card_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Homepage Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DecoratedContainer(),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  CardItem(
                    title: 'Tournaments',
                    icon: Icons.sports_esports,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TournamentsScreen()),
                      );
                    },
                  ),
                  CardItem(
                    title: 'Teams',
                    icon: Icons.group,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeamsScreen()),
                      );
                    },
                  ),
                  CardItem(
                    title: 'Venues',
                    icon: Icons.location_on,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VenuesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuario: Yickshina',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Zachir Faundez',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/images/profile.png',
            width: 125,
            height: 125,
          ),
        ],
      ),
    );
  }
}
