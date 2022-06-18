import 'package:restroapp/models/restaurants.dart';

class Booking {
  String userId, bookingId, paymentId, paymentSignature;
  Restaurants restaurants;
  DateTime date;

  Booking(
      {required this.bookingId,
      required this.paymentId,
      required this.paymentSignature,
      required this.restaurants,
      required this.date,
      required this.userId});
}
