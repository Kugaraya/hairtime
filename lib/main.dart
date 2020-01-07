import 'package:flutter/material.dart';
import 'package:hairtime/ui/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HairTime',
      theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.blueGrey[600]),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
