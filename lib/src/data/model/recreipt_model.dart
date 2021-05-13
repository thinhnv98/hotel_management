import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';

class Receipt {
  String id;
  DateTime date;
  String tenNhanVien;
  String toPhucVu;
  String description;
  RoomSession room;
  List<RoomService> roomServices;
  Receipt({
    this.id,
    this.date,
    this.tenNhanVien,
    this.toPhucVu,
    this.description,
    this.room,
    this.roomServices,
  });

  Receipt copyWith({
    String id,
    DateTime date,
    String tenNhanVien,
    String toPhucVu,
    String description,
    RoomSession room,
    List<RoomService> roomServices,
  }) {
    return Receipt(
      id: id ?? this.id,
      date: date ?? this.date,
      tenNhanVien: tenNhanVien ?? this.tenNhanVien,
      toPhucVu: toPhucVu ?? this.toPhucVu,
      description: description ?? this.description,
      room: room ?? this.room,
      roomServices: roomServices ?? this.roomServices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'tenNhanVien': tenNhanVien,
      'toPhucVu': toPhucVu,
      'description': description,
      'room': room?.toMap(),
      'roomServices': roomServices?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Receipt.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Receipt(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      tenNhanVien: map['tenNhanVien'],
      toPhucVu: map['toPhucVu'],
      description: map['description'],
      room: RoomSession.fromMap(map['room']),
      roomServices: List<RoomService>.from(
          map['roomServices']?.map((x) => RoomService.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Receipt.fromJson(String source) =>
      Receipt.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Receipt(id: $id, date: $date, tenNhanVien: $tenNhanVien, toPhucVu: $toPhucVu, description: $description, room: $room, roomServices: $roomServices)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Receipt &&
        o.id == id &&
        o.date == date &&
        o.tenNhanVien == tenNhanVien &&
        o.toPhucVu == toPhucVu &&
        o.description == description &&
        o.room == room &&
        listEquals(o.roomServices, roomServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        tenNhanVien.hashCode ^
        toPhucVu.hashCode ^
        description.hashCode ^
        room.hashCode ^
        roomServices.hashCode;
  }
}
