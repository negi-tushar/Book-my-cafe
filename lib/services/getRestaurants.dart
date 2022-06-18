import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restroapp/models/restaurants.dart';
import 'package:restroapp/provider/restaurants_provider.dart';

class FetchResturants {
  Future<List<Restaurants>> getResturants(BuildContext context) async {
    List<Restaurants> restaurants = [];
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      //  print(currentPosition);
      Uri url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition.latitude},${currentPosition.longitude}&radius=1500&type=restaurant&key=$apiKey');

      Response response = await http.get(url);
      print('called ----> api');
      var decodedData = json.decode(response.body);
      // print(decodedData['results']);
      if (decodedData['status'] == 'OK') {
        var fetchedList = decodedData['results'] as List;

        for (var element in fetchedList) {
          //print(element['rating']);
          restaurants.add(
            Restaurants(
                rating: double.tryParse(element['rating'].toString()) ?? 3.0,
                address: element['vicinity'],
                latitude: element['geometry']['location']['lat'],
                longitude: element['geometry']['location']['lng'],
                name: element['name'],
                businessStatus: element['business_status'],
                placeId: element['place_id'],
                distance: calculateDistance(
                    startLat: currentPosition.latitude,
                    startLng: currentPosition.longitude,
                    endLat: element['geometry']['location']['lat'],
                    endLng: element['geometry']['location']['lng'])),
          );
        }
        Provider.of<RestaurantsProvider>(context, listen: false)
            .updateRestaurants(restaurants);
      }
      // print(response.body);
    } catch (e) {
      print(e);
    }

    return restaurants;
  }

  String calculateDistance({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    double disMeter =
        Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    String disKM = (disMeter / 1000).toStringAsFixed(1);
    return disKM;
  }
}
