import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 255, 208, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Possibility to control boat manually",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 300,
              child: Image.asset(
                "assets/images/console.gif",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }
}
