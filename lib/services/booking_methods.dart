import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restroapp/models/restaurants.dart';

class BookingMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void confirmBooking(
      Restaurants restaurantsdetails, String status, var response) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('bookings')
          .add({
        'bookingId': response.orderId ?? '',
        'paymentId': response.paymentId ?? '',
        'paymentSignature': response.signature ?? '',
        'userId': _auth.currentUser!.uid,
        'date': DateTime.now(),
        'restaurantName': restaurantsdetails.name,
        'booking_Status': status,
      });
      //   print('====================>done<=================');
    } on FirebaseException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get bookingHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('bookings')
      .snapshots();
}
