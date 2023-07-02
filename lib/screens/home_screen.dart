import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leisure_boat/models/place.dart';

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
  LatLng? _pickedLocation = null;

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
      body: Stack(
        children: [
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
                        markerId: MarkerId("m1"), position: _pickedLocation!),
                  },
          )
        ],
      ),
    );
  }
}
