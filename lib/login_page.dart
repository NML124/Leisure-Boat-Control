import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leisure_boat/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  final routeName = "/login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var errorMessage = '';
  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signIn(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushReplacementNamed(context, "");
    } on HttpException catch (error) {
      errorMessage = "Authentification failed";
      if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "This email does not exist";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This email is not valid";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "This password is not correct";
      } else if (error.toString().contains("USER_DISABLED")) {
        errorMessage = "This user has been disabled";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = "Could not authenticate you. Please try again later";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            Container(
                height: 300,
                child: Image.asset(
                  "assets/images/logIn.jpg",
                )),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 18),
              ),
              controller: emailController,
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 18),
              ),
              controller: passwordController,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : OutlinedButton(
                    onPressed: () => _submit(),
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
