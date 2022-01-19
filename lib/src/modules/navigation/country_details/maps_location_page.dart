import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_test/src/modules/models/country_deails.dart';

class MapsLocationPage extends StatefulWidget {
  final Coordinates coords;
  final String countryName;

  const MapsLocationPage({Key key, @required this.coords, @required this.countryName}) : super(key: key);
  @override
  State<MapsLocationPage> createState() => MapsLocationPageState();
}

class MapsLocationPageState extends State<MapsLocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.coords.lat, widget.coords.lon),
          zoom: 6,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of([
          Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(widget.coords.lat, widget.coords.lon),
            infoWindow: InfoWindow(
            title: widget.countryName
          ))
        ]),
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }
}