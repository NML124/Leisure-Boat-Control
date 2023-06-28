import 'package:flutter/material.dart';
import 'package:leisure_boat/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _submit() async {
    await Provider.of<Auth>(context, listen: false).signIn(
      emailController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
                height: 300,
                child: Image.asset(
                  "assets/images/logIn.jpg",
                )),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
              controller: emailController,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              controller: passwordController,
            ),
            OutlinedButton(
              onPressed: () => _submit(),
              child: Text("Sign In"),
            )
          ]),
        ),
      ),
    );
  }
}
