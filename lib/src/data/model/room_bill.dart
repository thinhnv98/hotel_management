import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:hotel_management/src/data/model/room_session_model.dart';

class RoomSessionBill {
  String id;
  String employee;
  DateTime time;
  int total;
  RoomSession roomSession;
  String sessionId;

  RoomSessionBill({
    this.id,
    this.employee,
    this.time,
    this.total,
    this.roomSession,
    this.sessionId,
  });

  RoomSessionBill copyWith(
      {String id,
      String employee,
      DateTime time,
      int total,
      RoomSession roomSession,
      String sessionId}) {
    return RoomSessionBill(
      id: id ?? this.id,
      employee: employee ?? this.employee,
      time: time ?? this.time,
      total: total ?? this.total,
      roomSession: roomSession ?? this.roomSession,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee': employee,
      'time': time != null ? Timestamp.fromDate(time) : null,
      'total': total,
      'sessionId': sessionId,
    };
  }

  factory RoomSessionBill.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RoomSessionBill(
      id: map['id'],
      employee: map['employee'],
      sessionId: map['sessionId'],
      time: map['time'] != null ? (map['time'] as Timestamp).toDate() : null,
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomSessionBill.fromJson(String source) =>
      RoomSessionBill.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomSessionBill(id: $id, employee: $employee, time: $time, total: $total, roomSession: $roomSession, sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomSessionBill &&
        o.id == id &&
        o.employee == employee &&
        o.time == time &&
        o.total == total &&
        o.roomSession == roomSession &&
        o.sessionId == sessionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        employee.hashCode ^
        time.hashCode ^
        total.hashCode ^
        roomSession.hashCode ^
        sessionId.hashCode;
  }
}
