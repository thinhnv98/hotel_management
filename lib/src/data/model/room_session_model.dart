import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:hotel_management/src/data/model/room_service_model.dart';

class RoomSession {
  String id;
  String visitorName;
  String roomId;
  int prepaid;
  int price;
  String description;
  String roomName;
  String roomUrl;
  DateTime start;
  DateTime end;
  List<RoomService> roomServices;

  RoomSession({
    this.id,
    this.visitorName,
    this.roomId,
    this.prepaid,
    this.price,
    this.description,
    this.roomName,
    this.roomUrl,
    this.start,
    this.end,
    this.roomServices,
  });

  RoomSession copyWith({
    String id,
    String visitorName,
    String roomId,
    double prepaid,
    int price,
    String description,
    String roomName,
    String roomUrl,
    DateTime start,
    DateTime end,
    List<RoomService> roomServices,
  }) {
    return RoomSession(
      id: id ?? this.id,
      visitorName: visitorName ?? this.visitorName,
      roomId: roomId ?? this.roomId,
      prepaid: prepaid ?? this.prepaid,
      price: price ?? this.price,
      description: description ?? this.description,
      roomName: roomName ?? this.roomName,
      roomUrl: roomUrl ?? this.roomUrl,
      start: start ?? this.start,
      end: end ?? this.end,
      roomServices: roomServices ?? this.roomServices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'visitorName': visitorName,
      'roomId': roomId,
      'prepaid': prepaid,
      'price': price,
      'description': description,
      'roomName': roomName,
      'roomUrl': roomUrl,
      'start': start != null ? Timestamp.fromDate(start) : null,
      'end': end != null ? Timestamp.fromDate(end) : null,
      'roomServices': roomServices?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory RoomSession.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return RoomSession(
      id: map['id'].toString(),
      visitorName: map['visitorName'],
      roomId: map['roomId'],
      prepaid: map['prepaid'],
      price: map['price'],
      description: map['description'],
      roomName: map['roomName'],
      roomUrl: map['roomUrl'],
      start: map['start'] != null ? (map['start'] as Timestamp).toDate() : null,
      end: map['end'] != null ? (map['end'] as Timestamp).toDate() : null,
      roomServices: map['roomServices'] != null
          ? List<RoomService>.from(
              map['roomServices']?.map((x) => RoomService.fromMap(x)))
          : null,
    );
  }

  static Future<RoomSession> fromSnapshot(DocumentSnapshot snapshot) async {
    var listService = await snapshot.reference
        .collection("session_services")
        .get()
        .then((value) =>
            value.docs.map((e) => RoomService.fromMap(e.data())).toList());

    return RoomSession(
      id: snapshot.data()['id'],
      description: snapshot.data()['description'],
      end: snapshot.data()['end'] != null
          ? (snapshot.data()['end'] as Timestamp).toDate()
          : null,
      roomServices: listService,
      prepaid: snapshot.data()['prepaid'],
      roomId: snapshot.data()['roomId'],
      start: snapshot.data()['start'] != null
          ? (snapshot.data()['start'] as Timestamp).toDate()
          : null,
      visitorName: snapshot.data()['visitorName'],
    );
  }

  int totalMoney() {
    int total =
        (DateTime.now().difference(this.start).inDays + 1) * this.price -
            this.prepaid;
    int totalServices = 0;
    this.roomServices?.forEach((element) {
      totalServices += element.price;
    });
    return total + totalServices;
  }

  String toJson() => json.encode(toMap());

  factory RoomSession.fromJson(String source) =>
      RoomSession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomSession(id: $id, visitorName: $visitorName, roomId: $roomId, prepaid: $prepaid, description: $description, start: $start, end: $end, roomServices: $roomServices)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomSession &&
        o.id == id &&
        o.visitorName == visitorName &&
        o.roomId == roomId &&
        o.prepaid == prepaid &&
        o.description == description &&
        o.start == start &&
        o.end == end &&
        listEquals(o.roomServices, roomServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        visitorName.hashCode ^
        roomId.hashCode ^
        prepaid.hashCode ^
        description.hashCode ^
        start.hashCode ^
        end.hashCode ^
        roomServices.hashCode;
  }
}
