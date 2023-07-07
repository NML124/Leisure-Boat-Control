import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leisure_boat/providers/auth.dart';
import 'package:leisure_boat/screens/authentificate_screen.dart';
import 'package:leisure_boat/screens/home_screen.dart';
import 'package:leisure_boat/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          home: Auth().isAuthenticated
              ? Home()
              : FutureBuilder(
                  future: Auth().tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : authResultSnapshot.data == false
                              ? AuthentificateScreen()
                              : Home(),
                ),
          routes: {
            Home().routeName: (_) => Home(),
            Welcome().routeName: (_) => Welcome(),
            const AuthentificateScreen().routeName: (_) =>
                const AuthentificateScreen(),
          }),
    );
  }
}
