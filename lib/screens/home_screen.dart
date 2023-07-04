import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

import '../models/boat.dart';

class Home extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  Home({
    this.initialLocation =
        const PlaceLocation(latitude: -4.3515904, longitude: 15.2993792),
    this.isSelecting = true,
  });
  final routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedBoat = "";
  var boats;
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase database = FirebaseDatabase.instance;
  LatLng? _pickedLocation = null;

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    dbRef.child("Boats").onValue.listen((event) {
      final map = event.snapshot.children;
      var temporaryboats = [];
      map.forEach((child) {
        var location = child.child("ActualPosition").value;
        var target = child.child("Target").value;
        var speed = child.child("ActualSpeed").value;
        var name = child.child("Name").value;
        var isAutomatic = child.child("IsAutomatic").value;
        var id = child.key.toString();
        List<String> latlng = location.toString().split(",");
        LatLng locationBoat =
            LatLng(double.parse(latlng[0]), double.parse(latlng[1]));
        setState(() {
          temporaryboats.add({
            "id": id,
            "ActualPosition": locationBoat,
            "Target": target,
            "Speed": speed,
            "Name": name,
            "Automatic": isAutomatic
          });
        });
      });
      boats = temporaryboats;
    });
  }

  Future<void> _modifyBoat(Boat boat,
      {LatLng? target,
      Double? desiredSpeed,
      Double? desiredOrientation,
      Bool? isAutomatic}) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("boats/$selectedBoat");
    await ref.update({
      "desiredSpeed": desiredSpeed == null ? boat.speed : desiredSpeed,
      "desiredOrientation":
          desiredOrientation == null ? boat.orientation : desiredOrientation,
      "automatic": isAutomatic == null ? boat.isAutomatic : isAutomatic,
      "target": target == null
          ? (boat.target!.latitude, boat.target!.longitude)
          : (target.latitude, target.longitude),
    });
  }

  Widget map(boats) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.initialLocation.latitude,
          widget.initialLocation.longitude,
        ),
        zoom: 16,
      ),
      onTap: widget.isSelecting ? _selectedLocation : null,
      markers: _pickedLocation == null
          ? {}
          : {
              Marker(
                markerId: MarkerId("m1"),
                position: _pickedLocation!,
              ),
            },
    );
  }

  void _selectedLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final email = routeArgs['email'];

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _activeListeners,
          child: Text("Recharger"),
        ),
      ],
    )));
  }
}
