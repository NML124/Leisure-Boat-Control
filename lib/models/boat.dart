import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import './orientation.dart';
import './passenger.dart';
import './path.dart';
import './speed.dart';
import './trip_duration.dart';

class Boat {
  String? _name;
  bool? _isAutomatic;
  Path? _path;
  LatLng? _actualLocation;
  Speed? _speed;
  TripDuration? _tripDuration;
  Orientation? _orientation;
  Passenger? _passengers;

  Boat(this._name, this._isAutomatic, this._path, this._actualLocation,
      this._tripDuration, this._speed, this._orientation, this._passengers);

  String? get name => _name;
  bool? get isAutomatic => _isAutomatic;
  double? get distanceToTarget => _path!.distance;
  LatLng? get target => _path!.target;
  LatLng? get location => _actualLocation;
  double? get speed => _speed!.actualSpeed;
  double? get desiredSpeed => _speed!.desiredSpeed;
  int? get travelTime => _tripDuration!.travelTime;
  double? get orientation => _orientation!.actualOrientation;
  double? get desiredOrientation => _orientation!.desiredOrientation;
  int? get numberPassengers => _passengers!.number;

  void setTarget(LatLng target) {
    _path!.setTarget(target);
  }

  void setMode(bool mode) {
    _isAutomatic = mode;
  }
}
