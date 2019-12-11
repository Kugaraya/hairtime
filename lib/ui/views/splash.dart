import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashDisplay extends StatefulWidget {
  @override
  _SplashDisplayState createState() => _SplashDisplayState();
}

class _SplashDisplayState extends State<SplashDisplay> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: '/start',
      title: Text(
        "HairTime",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset('assets/logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader:
          TextStyle(fontSize: 8.0, color: Colors.grey[400]),
      photoSize: 100.0,
      onClick: () => Fluttertoast.showToast(
          msg: "Relax, the app will load in a bit",
          backgroundColor: Colors.black38,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12.0,
          textColor: Colors.white,
          timeInSecForIos: 1,
          toastLength: Toast.LENGTH_SHORT),
    );
  }
}
