class Address {
  String placeName, placeId, placeFormattedAddress;
  double latitude, longitude;

  Address({
    required this.latitude,
    required this.longitude,
    required this.placeFormattedAddress,
    required this.placeId,
    required this.placeName,
  });
}
