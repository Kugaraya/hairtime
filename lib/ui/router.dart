import 'package:flutter/material.dart';
import 'package:hairtime/ui/shared/loginanim.dart';
import 'package:hairtime/ui/views/dashboard.dart';
import 'package:hairtime/ui/views/main-page.dart';
import 'package:hairtime/ui/views/splash.dart';

class Router {
  static Route<dynamic> generateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashDisplay());
      case '/start':
        return MaterialPageRoute(builder: (_) => LoginAnimate());
      case '/main':
        return MaterialPageRoute(builder: (_) => DashboardMain());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
