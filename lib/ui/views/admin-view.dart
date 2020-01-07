import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:hairtime/core/services/auth-service.dart';

class AdminView extends StatefulWidget {
  AdminView(
      {Key key, this.userEmail, this.userId, this.auth, this.logoutCallback})
      : super(key: key);

  final String userEmail;
  final String userId;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  AnimationController opacityController;

  @override
  void initState() {
    super.initState();
    AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  final db = Firestore.instance;

  Widget _itemTiles(DocumentSnapshot document) {
    return Dismissible(
        key: Key(document.documentID),
        direction: DismissDirection.startToEnd,
        movementDuration: Duration(milliseconds: 500),
        background: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.red,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 35.0,
              ),
            ),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey[400],
                  style: BorderStyle.solid,
                  width: 0.33)),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            title: Text(document["queue-email"]),
            subtitle: Text("Queued since " +
                timeago.format(document["queue-time"].toDate())),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        onDismissed: (_) async {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Order dismissed"),
            duration: Duration(milliseconds: 500),
          ));
          await db
              .collection("queue-list")
              .document(document.documentID)
              .delete();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Queue Manager"),
        leading: IconButton(
          onPressed: widget.logoutCallback,
          icon: Transform.rotate(
              angle: 180 * math.pi / 180, child: Icon(Icons.exit_to_app)),
        ),
      ),
      body: StreamBuilder(
        stream: db.collection("queue-list").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _itemTiles(snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }
}
