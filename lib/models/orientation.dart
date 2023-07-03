class Orientation {
  double? _actualOrientation;
  double? _desiredOrientation;

  Orientation(this._actualOrientation, this._desiredOrientation);

  double get actualOrientation => _actualOrientation!;
  double get desiredOrientation => _desiredOrientation!;

  void setdesiredOrientation(double orientation) {
    _desiredOrientation = orientation;
  }
}
