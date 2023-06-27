import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Visualize our boat",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 300,
            child: Image.asset(
              "assets/images/login_page_GPS.gif",
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
    );
  }
}
