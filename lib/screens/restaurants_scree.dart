import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:restroapp/constants/utils.dart';

import 'package:restroapp/models/restaurants.dart';
import 'package:restroapp/models/users.dart';
import 'package:restroapp/provider/location_provider.dart';
import 'package:restroapp/provider/userProvider.dart';
import 'package:restroapp/screens/google_map_screen.dart';
import 'package:restroapp/services/booking_methods.dart';
import 'package:restroapp/widgets/bottom_navigationbar.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
  static const String id = '/RestaurantScreen';

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Restaurants restaurants = Restaurants(
      distance: '',
      rating: 0.0,
      address: '',
      latitude: 0.0,
      longitude: 0.0,
      name: '',
      businessStatus: '',
      placeId: '');
  Users user = Users(mobile: '', name: '', email: '', id: '');
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Successful!!');

    BookingMethods().confirmBooking(restaurants, 'Success', response);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MyBottomNavigationBar.id, (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    // print('Failed, Please try again');
    showSnackBar(context, 'Payment Failed!,Please try again', Colors.red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('External Wallet');
  }

  void openCheckOut() {
    var options = {
      'key': 'rzp_test_tTlC1UX2xw6kuB',
      'amount': 20000,
      'name': user.name,
      'description': 'Book table',
      'prefill': {'contact': user.mobile, 'email': user.email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void didChangeDependencies() {
    restaurants = ModalRoute.of(context)?.settings.arguments as Restaurants;
    user = Provider.of<UserProvider>(context, listen: false).getUser;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BookNow'),
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.pin_drop_rounded),
      // ),
      body: Container(
          padding: const EdgeInsets.all(10),
          //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      restaurants.name,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: 55,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              '${restaurants.rating} ⋆',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            width: 55,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              '${restaurants.distance} km',
                              textAlign: TextAlign.center,
                              style: kLabel,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.pin_drop_outlined),
                label: Text(
                  restaurants.address,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 30,
                decoration: BoxDecoration(
                    color: restaurants.businessStatus == 'OPERATIONAL'
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                    'Status: ${restaurants.businessStatus.substring(0, 1).toUpperCase()}${restaurants.businessStatus.substring(1, restaurants.businessStatus.length).toLowerCase()}'),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Image(
                      image: NetworkImage(images[index]),
                      height: 50,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              kHeightSpacer(10),
              TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => MyMap(
                              restaurantName: restaurants.name,
                              home: LatLng(
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .currentAddress!
                                    .latitude,
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .currentAddress!
                                    .longitude,
                              ),
                              destination: LatLng(
                                  restaurants.latitude, restaurants.longitude),
                            ));
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('View on Map')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    openCheckOut();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Book Table')),
              kHeightSpacer(10),
            ],
          )),
    );
  }
}
