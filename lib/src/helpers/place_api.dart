import 'package:firebase_database/firebase_database.dart';
import '../model/place.dart';

Future<List<Place>> fetchPlaces() async {
  final databaseReference = FirebaseDatabase.instance.ref();
  final dataSnapshot = await databaseReference.child('places').once();

  if (dataSnapshot.snapshot.value != null) {
    Map<String, dynamic> jsonResponse = Map<String, dynamic>.from(dataSnapshot.snapshot.value as Map);
    List<Place> places = jsonResponse.entries.map((entry) => Place.fromJson(entry.key, entry.value.cast<String, dynamic>())).toList();
    return places;
  } else {
    throw Exception('Failed to load places');
  }
}

Future<Place> addPlace(Place place) async {
  final databaseReference = FirebaseDatabase.instance.ref();
  final newPlaceRef = databaseReference.child('places').push();

  // Asignar la clave generada por Firebase al objeto place.
  place.key = newPlaceRef.key!;

  await newPlaceRef.set(place.toJson());

  // Devolver el objeto place actualizado.
  return place;
}

Future<void> deletePlace(String key) async {
  final databaseReference = FirebaseDatabase.instance.ref();
  return databaseReference.child('places').child(key).remove();
}

Future<void> updatePlace(Place place) async {
  final databaseReference = FirebaseDatabase.instance.ref();

  await databaseReference.child('places').child(place.key).set(place.toJson());
}
