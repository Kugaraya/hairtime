import 'package:flutter/material.dart';
import 'package:hairtime/core/services/auth-service.dart';
import 'package:hairtime/ui/views/admin-view.dart';
import 'package:hairtime/ui/views/user-view.dart';

class DashboardMain extends StatefulWidget {
  DashboardMain(
      {Key key, this.auth, this.userId, this.logoutCallback, this.userEmail})
      : super(key: key);

  final String userEmail;
  final String userId;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.userId.contains("Ul0qXlXt1RaiYjaAFeMLaeBdWU42")
          ? AdminView(
              userEmail: widget.userEmail,
              userId: widget.userId,
              auth: widget.auth,
              logoutCallback: widget.logoutCallback,
            )
          : UserView(
              userEmail: widget.userEmail,
              userId: widget.userId,
              auth: widget.auth,
              logoutCallback: widget.logoutCallback,
            ),
    );
  }
}
