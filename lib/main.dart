import 'package:flutter/material.dart';
import 'package:leisure_boat/providers/auth.dart';
import 'package:leisure_boat/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Leisure Boat Controler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 103, 58, 183)),
          useMaterial3: true,
        ),
        home: Welcome(),
      ),
    );
  }
}
