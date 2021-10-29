import 'package:caruviuserapp/views/homepage.dart';
import 'package:caruviuserapp/views/login.dart';
import 'package:caruviuserapp/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          if (prefs.hasData) {
            if (prefs.data!.containsKey('isloggedin')) {
              return MaterialApp(
                title: 'Caruvi Agro Online',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.green,
                ),
                home: HomePage(),
              );
            } else {
              return MaterialApp(
                title: 'Caruvi Agro Online',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.green,
                ),
                home: LoginPage(),
              );
            }
          }

          return MaterialApp(
            title: 'Caruvi Services',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
            ),
            home: WelcomePage(),
          );
        });
  }
}
