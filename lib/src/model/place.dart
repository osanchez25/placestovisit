class Place {
  String key;
  final String name;
  late final String imageUrl;
  final String imageKey;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final double rating;
  final String category;
  final int tripId;

  Place({
    required this.key,
    required this.name,
    required this.imageUrl,
    required this.imageKey,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.rating,
    required this.category,
    required this.tripId
  });

  factory Place.fromJson(String key,Map<String, dynamic> json) {
    return Place(
      key: key,
      name: json['name'],
      imageUrl: json['image_url'],
      imageKey: json['image_key'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      address: json['address'],
      rating: json['rating'].toDouble(),
      category: json['category'],
      tripId: json['trip_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_key': imageKey,
      'image_url': imageUrl,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'rating': rating,
      'category': category,
      'trip_id': tripId,
    };
  }
}
