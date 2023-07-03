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
  Map boats = {};
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("boats");
  LatLng? _pickedLocation = null;

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
    return Stack(
      children: [
        Text("Louis de Viniac"),
      ],
    );
  }

  void _selectedLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_ref = FirebaseDatabase.instance.ref().child('boats');
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final email = routeArgs['email'];

    return Scaffold(
      body: Stack(
        children: [
          FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                print("Bouh");
                return map(boats);
              }),
          GoogleMap(
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
          ),
        ],
      ),
    );
  }
}
