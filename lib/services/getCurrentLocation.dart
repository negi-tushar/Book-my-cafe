// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restroapp/models/address.dart';
import 'package:restroapp/provider/location_provider.dart';
import 'package:restroapp/services/getRestaurants.dart';

class CurrentLocation {
  void getCurrentLocation(BuildContext context) async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      //  print(currentPosition);

      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentPosition.latitude},${currentPosition.longitude}&key=$apiKey';

      var response = await http.get(Uri.parse(url));
      var res = json.decode(response.body);
      if (res['status'] == 'OK') {
        var res = json.decode(response.body);
        Address address = Address(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude,
            placeFormattedAddress: res['results'][1]['formatted_address'],
            placeId: res['results'][0]['place_id'],
            placeName: res['results'][0]['plus_code']['compound_code']);

        Provider.of<LocationProvider>(context, listen: false)
            .updateCurrentAddress(address);
        await FetchResturants().getResturants(context);
      }
    } catch (e) {
      print('error ---->>> $e');
    }
  }
}
