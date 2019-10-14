import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hairtime/screens/login/loginanim.dart';
import 'package:hairtime/screens/register/register.dart';
import 'package:hairtime/screens/splash/splash.dart';
import 'package:hairtime/screens/login/login.dart';
import 'package:hairtime/screens/dashboard/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HairTime',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        accentColor: Colors.blueGrey[900]
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashDisplay(),
        '/after' : (context) => LoginAnimate(),
        '/login' : (context) => LoginScreen(),
        '/register' : (context) => RegisterScreen(),
        '/dashboard' : (context) => DashboardScreen(),
      },
    );
  }
}
