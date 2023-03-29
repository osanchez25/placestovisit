import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../helpers/place_api.dart';
import '../model/place.dart';
import 'place_details_page.dart';

class PlacesListPage extends StatefulWidget {
  @override
  _PlacesListPageState createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  late Future<List<Place>> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futurePlaces = fetchPlaces();
          });
        },
        child: FutureBuilder<List<Place>>(
          future: _futurePlaces,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitDoubleBounce(color: Colors.blue));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final places = snapshot.data!;
              return ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return ListTile(
                    title: Text(place.name),
                    subtitle: Text(place.category),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceFormPage(place: place),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deletePlace(place.key).then((_) {
                              setState(() {
                                _futurePlaces = fetchPlaces();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceFormPage(),
          ),
        ).then((_) {
          setState(() {
            _futurePlaces = fetchPlaces();
          });
        });
      },
      child: Icon(Icons.add),
    ),
    );
  }
}
