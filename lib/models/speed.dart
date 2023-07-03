class Speed {
  final double? _actualSpeed;
  double? _desiredSpeed;

  Speed(this._actualSpeed, this._desiredSpeed);

  double get actualSpeed => _actualSpeed!;
  double get desiredSpeed => _desiredSpeed!;

  void setDesiredSpeed(double speed) {
    _desiredSpeed = speed;
  }
}
