import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:leisure_boat/models/boat.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class ModalBottomSheetBoat extends StatefulWidget {
  var _boat = {};
  DatabaseReference _dbRef;
  ModalBottomSheetBoat(this._boat, this._dbRef, {super.key});

  @override
  State<ModalBottomSheetBoat> createState() => __ModalBottomSheetBoatState();
}

class __ModalBottomSheetBoatState extends State<ModalBottomSheetBoat> {
  double mapValueJoystick(value, newMax) {
    return (value + 1) * (newMax / 2);
  }

  @override
  Widget build(BuildContext context) {
    var boat = widget._boat;
    var dbRef = widget._dbRef;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        child: Column(
          children: [
            Text(
              boat["Name"],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Boat DATA",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Speed : ${boat['Speed']} rpm",
                  style: TextStyle(fontSize: 15),
                ),
                Text("Orientation : ${boat["Orientation"]}°",
                    style: TextStyle(fontSize: 15)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Automatic :",
                      style: TextStyle(fontSize: 15),
                    ),
                    Switch(
                        value: boat['Automatic'],
                        onChanged: (value) {
                          setState(() {
                            boat['Automatic'] = value;
                          });
                          dbRef
                              .child("Boats")
                              .child(boat['id'])
                              .update({'IsAutomatic': boat['Automatic']});
                        }),
                  ],
                ),
                SizedBox(height: 10),
                boat['Automatic']
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Joystick(
                              mode: JoystickMode.horizontal,
                              listener: (value) {
                                setState(() {
                                  boat['ServoMotorValue'] =
                                      mapValueJoystick(value.x, 180);
                                });
                                dbRef.child("Boats").child(boat['id']).update({
                                  'ServoMotorValue': boat['ServoMotorValue']
                                });
                              }),
                          SizedBox(width: 10),
                          SfSlider.vertical(
                              value: boat['DCMotorValue'].toDouble(),
                              min: 0,
                              max: 255,
                              enableTooltip: true,
                              showLabels: true,
                              onChanged: (value) {
                                setState(() {
                                  boat['DCMotorValue'] = value.toInt();
                                });
                                dbRef.child("Boats").child(boat['id']).update(
                                    {'DCMotorValue': boat['DCMotorValue']});
                              })
                        ],
                      )
                    : Container(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
