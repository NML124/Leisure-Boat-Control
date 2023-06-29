import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  final routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final email = routeArgs['email'];

    return Scaffold(
      body: Center(child: Text(email!)),
    );
  }
}
