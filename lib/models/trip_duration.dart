import './path.dart';

import './speed.dart';

class TripDuration {
  Speed? _speed;
  Path? _path;

  TripDuration(this._speed, this._path);

  int get travelTime => _path!.distance ~/ _speed!.actualSpeed;
}
