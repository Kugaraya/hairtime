import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hairtime/core/services/auth-service.dart';

class UserView extends StatefulWidget {
  UserView(
      {Key key, this.userEmail, this.userId, this.auth, this.logoutCallback})
      : super(key: key);

  final String userEmail;
  final String userId;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final db = Firestore.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selected = -1;
  List<String> _hairCut = [
    "Regular",
    "Crew Cut",
    "Undercut",
    "Ducktail",
    "Buzz Cut",
    "Comb Over",
    "Top Knot",
    "Quiff",
  ];

  @override
  Widget build(BuildContext context) {
    Widget forCounter() {
      return StreamBuilder(
        stream: db.collection('queue-list').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Text("Waiting");
          }
          int counter = snapshot.data.documents.length;
          String suffix =
              counter == 0 ? "" : counter == 1 ? " Person" : " People";
          return Text(
            "Current Queue: " + counter.toString() + suffix,
            style: TextStyle(color: Colors.white),
          );
        },
      );
    }

    void _handleSubmitted() async {
      await db.collection("queue-list").add({
        "queue-email": widget.userEmail,
        "queue-order": _hairCut[_selected],
        "queue-time": Timestamp.now(),
        "queue-uid": widget.userId
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _selected != -1
          ? FloatingActionButton(
              onPressed: () {
                _handleSubmitted();
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Queued successfully"),
                  duration: Duration(seconds: 2),
                ));
                setState(() {
                  _selected = -1;
                });
              },
              child: Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 120.0,
              leading: IconButton(
                onPressed: widget.logoutCallback,
                icon: Transform.rotate(
                    angle: 180 * math.pi / 180, child: Icon(Icons.exit_to_app)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: Text(
                  widget.userEmail,
                  textScaleFactor: 0.9,
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    color: Theme.of(context).accentColor,
                    margin: EdgeInsets.only(bottom: 0.0),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: forCounter(),
                        ),
                      ],
                    ))),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  child: Card(
                    color: _selected == index
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    elevation: 6.0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selected = _selected == index ? -1 : index;
                        });
                      },
                      splashColor: _selected == index
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      child: GridTile(
                        header: GridTileBar(
                          title: Center(
                              child: Text("#" + (index + 1).toString(),
                                  textScaleFactor: 1.3,
                                  style: TextStyle(
                                      color: _selected == index
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))),
                        ),
                        child: Center(
                          child: Text(
                            _hairCut[index],
                            textScaleFactor: 1.8,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selected == index
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        footer: Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Text("4" + index.toString() + ".00 php",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: _selected == index
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    )))),
                      ),
                    ),
                  ),
                );
              }, childCount: _hairCut.length),
            )
          ],
        ),
      ),
    );
  }
}
