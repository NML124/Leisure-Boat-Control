import 'package:google_maps_flutter/google_maps_flutter.dart';

class Path {
  LatLng? _actualPosition;
  LatLng? _target;

  Path(this._actualPosition, this._target);

  double get distance => 5;
  LatLng get target => _target!;

  void setTarget(LatLng target) {
    _target = target;
  }
}
