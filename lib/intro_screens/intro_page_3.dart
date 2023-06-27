import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Everything with High Security",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 300,
            child: Image.asset(
              "assets/images/login_page_security.gif",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
