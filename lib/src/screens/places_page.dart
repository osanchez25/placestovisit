import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../custom/BorderIcon.dart';
import '../helpers/place_api.dart';
import '../model/place.dart';
import '../utils/constants.dart';
import '../utils/custom_functions.dart';
import '../utils/widget_functions.dart';
import 'place_details_page.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({Key? key}) : super(key: key);

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
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      //appBar: AppBar(title: const Text('Places to Visit 1.1')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futurePlaces = fetchPlaces();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(padding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    BorderIcon(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.menu,
                        color: COLOR_BLACK,
                      ),
                    ),
                    BorderIcon(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.settings,
                        color: COLOR_BLACK,
                      ),
                    ),
                  ]),
            ),
            addVerticalSpace(10),
            Padding(
              padding: sidePadding,
              child: Text(
                "Pendientes",
                style: themeData.textTheme.headline1,
              ),
            ),
            Padding(
                padding: sidePadding,
                child: const Divider(
                  height: 25,
                  color: COLOR_GREY,
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: ["Caminatas", "Restaurantes", "Cataratas", "Playa"]
                    .map((filter) => ChoiceOption(text: filter))
                    .toList(),
              ),
            ),
            addVerticalSpace(10),
            Flexible(
                child: Padding(
              padding: sidePadding,
              child: FutureBuilder<List<Place>>(
                future: _futurePlaces,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitDoubleBounce(color: Colors.blue));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final places = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return PlaceListTile(
                          place: place,
                          onUpdate: (updatedPlace) {
                            setState(() {
                              final index = places.indexWhere(
                                  (place) => place.key == updatedPlace.key);
                              if (index >= 0) {
                                places[index] = updatedPlace;
                                _futurePlaces = Future.value(places);
                              }
                            });
                          },
                          onDelete: () {
                            deletePlace(place.key).then((_) {
                              setState(() {
                                List<Place> newPlaces = List.from(places)
                                  ..remove(place);
                                _futurePlaces = Future.value(newPlaces);
                              });
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            )),
          ],
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({
    Key? key,
    required this.place,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  final Place place;
  final Function(Place) onUpdate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
//Codigo para borrar con swipe a la izquierda
    return Dismissible(
      key: Key(place.key),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (direction) => onDelete(),
      child: GestureDetector(
        onTap: () async {
          Place? updatedPlace = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceFormPage(place: place),
            ),
          );
          if (updatedPlace != null) {
            onUpdate(updatedPlace);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FutureBuilder<Uint8List?>(
                          future: _loadImageFromFirebaseStorage(place.imageUrl),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Icon(Icons.error);
                            } else {
                              return snapshot.data != null
                                  ? Image.memory(snapshot.data!)
                                  : const Icon(Icons.image);
                            }
                          })),
                  const Positioned(
                      top: 15,
                      right: 15,
                      child: BorderIcon(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.favorite_border,
                            color: COLOR_BLACK,
                          )))
                ],
              ),
              addVerticalSpace(15),
              Row(
                children: [
                  Text(
                    place.name,
                    style: themeData.textTheme.headline1,
                  ),
                  addHorizontalSpace(10),
                  Text(
                    place.description,
                    style: themeData.textTheme.bodyText2,
                  )
                ],
              ),
              addVerticalSpace(10),
              Text(
                "${place.category}  / ${place.rating}  / ${place.category} ",
                style: themeData.textTheme.headline5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: COLOR_GREY.withAlpha(25),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: themeData.textTheme.headline5,
      ),
    );
  }
}

Future<Uint8List?> _loadImageFromFirebaseStorage(String imageKey) async {
  try {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("Places_Pictures")
        .child(imageKey);
    final bytes = await ref.getData();
    return bytes;
  } catch (e) {
    print('Error cargando la imagen: $e');
    return null;
  }
}
