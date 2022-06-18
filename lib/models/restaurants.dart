class Restaurants {
  String name;
  String businessStatus;
  String placeId;
  String address;
  double latitude, longitude;
  double rating;
  String distance;
  Restaurants({
    required this.distance,
    required this.rating,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.businessStatus,
    required this.placeId,
  });
}
