import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
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
  var ports;
  List<Marker> _markers = [];
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase database = FirebaseDatabase.instance;
  LatLng? _pickedLocation = null;
  BitmapDescriptor boatMarkerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    addIcon();
    _databaseListeners();
  }

  void addIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/boatMarker.png")
        .then(
      (icon) {
        setState(() {
          boatMarkerIcon = icon;
        });
      },
    );
  }

  void _databaseListeners() {
    dbRef.child("Boats").onValue.listen((event) {
      final map = event.snapshot.children;
      var temporaryboats = [];
      List<String> latlng;

      map.forEach((child) {
        var location = child.child("ActualPosition").value;
        var target = child.child("Target").value;
        var speed = child.child("ActualSpeed").value;
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
            "Speed": speed,
            "Name": name,
            "Automatic": isAutomatic
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
    log(boats.length.toString());
    for (var boat in boats) {
      log(boats[0]["ActualPosition"].latitude.toString());
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
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.initialLocation.latitude,
          widget.initialLocation.longitude,
        ),
        zoom: 10,
      ),
      onTap: widget.isSelecting ? _selectedLocation : null,
      markers: _markers.toSet(),
    ));
  }
}
