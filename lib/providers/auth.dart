import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> signIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyClUXtWb8H5KMhdFXWHgg6y4v4jywP669Y';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(json.decode(response.body));
  }
}
