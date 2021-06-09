import 'package:flutter/material.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
class edit_Room_screen extends StatelessWidget {
  final RoomSession roomSession;
  final Room room;
  edit_Room_screen({@required this.roomSession, @required this.room});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text(
        "This is delete Tab",
        style: new TextStyle(fontSize: 25.0),
      ),
    );
  }
}