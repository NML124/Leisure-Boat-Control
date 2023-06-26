import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 243, 205, 33),
      child: Column(children: const [
        Text("Possibility to control boat manually"),
      ]),
    );
  }
}
