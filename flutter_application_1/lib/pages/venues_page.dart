import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/create_venue_page.dart';
import 'package:flutter_application_1/services/http_service.dart';
import 'package:flutter_application_1/services/http_service_2.dart';

class VenuesScreen extends StatefulWidget {
  @override
  _VenuesScreenState createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  late Future<List<dynamic>> _venues;

  @override
  void initState() {
    super.initState();
    _venues = HttpService().listData('venues');
  }

  void _loadVenues() {
    setState(() {
      _venues = HttpService().listData('venues');
    });
  }

  void _deleteVenue(int venueId) async {
    bool deleted = await HttpService2().deleteVenue(venueId);
    if (deleted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Venue deleted successfully'),
      ));
      _loadVenues(); // Reload the list of venues after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete venue'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venues'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var newVenue = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateVenueScreen(),
                ),
              );

              if (newVenue != null) {
                _loadVenues();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _venues,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No venues found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var venue = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        venue['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(venue['city']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteVenue(venue['id']);
                            },
                          ),
                          // Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        // Add your own details page or functionality here
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
