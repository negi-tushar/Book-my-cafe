// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restroapp/services/getDirectionDetails.dart';

class MyMap extends StatefulWidget {
  const MyMap(
      {Key? key,
      required this.destination,
      required this.home,
      required this.restaurantName})
      : super(key: key);
  final LatLng destination;
  final LatLng home;
  final String restaurantName;
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  bool didchange = true;
  Future<void> getDirections() async {
    var details = await GetDirectionDetails.getDirecction(
        widget.home, widget.destination);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(details!.encodedPoints);
    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      for (var point in results) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId('polyid'),
          color: Colors.brown,
          points: polylineCoordinates,
          jointType: JointType.round,
          width: 3,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap);

      _polylines.clear();
      _polylines.add(polyline);
    });

    Marker myLocationMarker = Marker(
      markerId: MarkerId('myLocation'),
      position: widget.home,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.2),
          'assets/images/pickicon.png'),
      infoWindow: InfoWindow(title: "You", snippet: "Home"),
    );
    Marker restaurantMarker = Marker(
      markerId: MarkerId('restaurantMarker'),
      position: widget.destination,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.2),
          'assets/images/redmarker.png'),
      infoWindow:
          InfoWindow(title: widget.restaurantName, snippet: "Restaurant"),
    );
    setState(() {
      _markers.add(myLocationMarker);
      _markers.add(restaurantMarker);
    });
  }

  @override
  void didChangeDependencies() async {
    if (didchange) {
      await getDirections();
    }
    setState(() {
      didchange = false;
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //  mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GoogleMap(
                padding: const EdgeInsets.all(10),
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                // myLocationEnabled: true,
                initialCameraPosition:
                    CameraPosition(target: widget.home, zoom: 14.2346),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
              ),
            )
          ],
        ),
      ),
    );
  }
}
