import 'package:avatar_glow/avatar_glow.dart';
import 'package:hairtime/models/animatedlogin.dart';
import 'package:flutter/material.dart';

class LoginAnimate extends StatefulWidget {
  @override
  _LoginAnimateState createState() => _LoginAnimateState();
}

class _LoginAnimateState extends State<LoginAnimate> with SingleTickerProviderStateMixin {
  final int delayedAmount = 200;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 1),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(
                      Icons.person_pin,
                      color: Theme.of(context).primaryColor,
                      size: 70.0,
                    ),
                    radius: 50.0,
                  )
                ),
              ),
            ),
            DelayedAnimation(
              child: Text(
                "Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    color: color),
              ),
              delay: delayedAmount + 500,
            ),
            DelayedAnimation(
              child: Text(
                "to 'HairTime'",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  color: color
                ),
              ),
              delay: delayedAmount + 1000,
            ),
            SizedBox(
              height: 30.0,
            ),
            DelayedAnimation(
              child: Text(
                "Where everyone learns",
                style: TextStyle(fontSize: 20.0, color: color),
              ),
              delay: delayedAmount + 1500,
            ),
            DelayedAnimation(
              child: Text(
                "at your touch",
                style: TextStyle(fontSize: 20.0, color: color),
              ),
              delay: delayedAmount + 1600,
            ),
            SizedBox(
              height: 100.0,
            ),
            DelayedAnimation(
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: _scale,
                child: _animatedButtonUI,
              ),
            ),
            delay: delayedAmount + 2000,
          ),
          SizedBox(height: 50.0,),
            DelayedAnimation(
              child: FlatButton(
                color: Colors.transparent,
                onPressed: () => Navigator.of(context).pushNamed('/register'),
                child: Text(
                  "I want to register an Account".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: color
                  ),
                ),
              ),
              delay: delayedAmount + 2300,
            ),
          ],
        ),
      )
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black38 ,blurRadius: 1.0, spreadRadius: 1.0)],
        ),
        child: FlatButton(
          splashColor: Colors.grey[50],
          onPressed: () => Navigator.of(context).pushNamed('/login'),
          child: Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}