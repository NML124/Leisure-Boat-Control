import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class Home extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  Home({
    this.initialLocation =
        const PlaceLocation(latitude: -2.0115168, longitude: 29.1144439),
    this.isSelecting = true,
  });
  final routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedBoat = "";
  var boats = [];
  var ports = [];
  List<Marker> _markers = [
    Marker(markerId: MarkerId("Origin"), position: LatLng(0, 0), visible: false)
  ];
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase database = FirebaseDatabase.instance;
  BitmapDescriptor boatMarkerIcon = BitmapDescriptor.defaultMarker;
  var step = 10.0;

  @override
  void initState() {
    super.initState();
    _databaseListeners();
  }

  void _databaseListeners() {
    dbRef.child("Boats").onValue.listen((event) {
      final map = event.snapshot.children;
      var temporaryboats = [];
      List<String> latlng;

      map.forEach((child) {
        var location = child.child("ActualPosition").value;
        var target = child.child("Target").value;
        var speed = double.parse(child.child("ActualSpeed").value.toString());
        var orientation =
            double.parse(child.child("Orientation").value.toString());
        var desiredSpeed =
            double.parse(child.child("DesiredSpeed").value.toString());
        var desiredOrientation =
            double.parse(child.child("DesiredOrientation").value.toString());
        var name = child.child("Name").value;
        var isAutomatic =
            bool.parse(child.child("IsAutomatic").value.toString());
        var id = child.key.toString();

        latlng = location.toString().split(",");
        LatLng locationBoat =
            LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

        latlng = target.toString().split(",");
        LatLng targetBoat =
            LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

        setState(() {
          temporaryboats.add({
            "id": id,
            "ActualPosition": locationBoat,
            "Target": targetBoat,
            "Orientation": orientation,
            "Speed": speed,
            "Name": name,
            "Automatic": isAutomatic,
          });
        });
      });
      boats = temporaryboats;
      initMarker();
    });

    dbRef.child("Ports").onValue.listen((event) {
      final map = event.snapshot.children;
      var temporaryPorts = [];
      List<String> latlng;

      map.forEach((child) {
        var location = child.child("Location").value;
        var name = child.child("Name").value;
        var id = child.key.toString();

        latlng = location.toString().split(",");
        LatLng locationPort =
            LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

        setState(() {
          temporaryPorts.add({
            "id": id,
            "Location": locationPort,
            "Name": name,
          });
        });
      });
      ports = temporaryPorts;
      initMarker();
    });
  }

  void initMarker() {
    log("Taille :" + ports.length.toString());
    for (var port in ports) {
      _markers.add(Marker(
        markerId: MarkerId(port["id"]),
        position: port["Location"],
        infoWindow: InfoWindow(
          title: port["Name"],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    }
    for (var boat in boats) {
      _markers.add(Marker(
        markerId: MarkerId(boat["id"]),
        position: boat["ActualPosition"],
        infoWindow: InfoWindow(
          title: boat["Name"],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.initialLocation.latitude,
          widget.initialLocation.longitude,
        ),
        zoom: 10,
      ),
      markers: _markers.toSet(),
    ));
  }
}
