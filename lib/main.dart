import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Management',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// In-memory storage for user data
class UserDataStore {
  static final Map<String, dynamic> _userData = {};

  static void saveUserData(String key, dynamic value) {
    _userData[key] = value;
  }

  static dynamic getUserData(String key) {
    return _userData[key];
  }

  static void clearUserData() {
    _userData.clear();
  }
}
