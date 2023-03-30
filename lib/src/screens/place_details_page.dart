import 'package:flutter/material.dart';

import '../helpers/place_api.dart';
import '../model/place.dart';

class PlaceFormPage extends StatefulWidget {
  final Place? place;

  PlaceFormPage({this.place});

  @override
  _PlaceFormPageState createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _category;
  late String _description;
  late String _imageUrl;
  late String _imageKey;
  late double _rating;
  late String _address;
  late double _latitude;
  late double _longitude;

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      _name = widget.place!.name;
      _category = widget.place!.category;
      _description = widget.place!.description;
      _imageKey = widget.place!.imageKey;
      _rating = widget.place!.rating;
      _address = widget.place!.address;
      _latitude = widget.place!.latitude;
      _longitude = widget.place!.longitude;
    } else {
      _name = '';
      _category = '';
      _description = '';
      _imageKey = '';
      _rating = 0;
      _address = '';
      _latitude = 0;
      _longitude = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place == null ? 'Add Place' : 'Edit Place'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  _category = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _imageKey,
                decoration: InputDecoration(labelText: 'Image Key'),
                onChanged: (value) {
                  _imageUrl = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                onChanged: (value) {
                  _rating = double.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address'),
                onChanged: (value) {
                  _address = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _latitude.toString(),
                decoration: InputDecoration(labelText: 'Latitude'),
                onChanged: (value) {
                  _latitude = double.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _longitude.toString(),
                decoration: InputDecoration(labelText: 'Longitude'),
                onChanged: (value) {
                  _longitude = double.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final place = Place(
                      key: widget.place?.key ?? '',
                      name: _name,
                      imageUrl: _imageUrl,
                      imageKey: _imageKey,
                      description: _description,
                      latitude: _latitude,
                      longitude: _longitude,
                      address: _address,
                      rating: _rating,
                      category: _category,
                      tripId: 1,
                    );
                    if (widget.place == null) {
                      // Agregar un nuevo objeto en Firebase Realtime Database
                      addPlace(place).then((newPlace) {
                        Navigator.pop(context,newPlace);
                      });
                    } else {
                      // Actualizar un objeto existente en Firebase Realtime Database
                      updatePlace(place).then((_) {
                        Navigator.pop(context,place);
                      });
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
