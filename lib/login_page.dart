import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            height: 300,
            child: Image.asset(
              "assets/images/logIn.jpg",
            )),
        TextField(
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        OutlinedButton(
          onPressed: () => null,
          child: Text("Sign In"),
        )
      ]),
    );
  }
}
