import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:restroapp/models/direction_model.dart';

class GetDirectionDetails {
  static Future<DirectionDetails?> getDirecction(
      LatLng start, LatLng end) async {
    DirectionDetails directionDetails = DirectionDetails(encodedPoints: '');
    try {
      Uri url = Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?destination=${end.latitude},${end.longitude}&origin=${start.latitude},${end.longitude}&key=$apiKey&mode=driving');
      http.Response response = await http.get(url);
      var decodedData = json.decode(response.body);
      // print(decodedData['routes'][0]['overview_polyline']['points']);
      if (decodedData['status'] == 'OK') {
        directionDetails.encodedPoints =
            decodedData['routes'][0]['overview_polyline']['points'];
        return directionDetails;
      }
    } catch (e) {
      print(e);
    }
    ;
  }
}
