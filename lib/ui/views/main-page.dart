import 'package:flutter/material.dart';
import 'package:hairtime/core/services/auth-service.dart';

class DashboardMain extends StatefulWidget {
  DashboardMain({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => widget.auth.signOut(),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            )),
        body: Center(
            child: Text(
          "Hey, you've logged in successfully",
          style: TextStyle(fontSize: 20.0),
        )));
  }
}
