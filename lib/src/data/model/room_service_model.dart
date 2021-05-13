import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  String serviceId;

  int quantity;
  int singularPrice;
  DateTime date;

  get price => quantity * singularPrice;

  RoomService({
    this.serviceId,
    this.quantity,
    this.singularPrice,
    this.date,
  });

  RoomService copyWith({
    String serviceId,
    int quantity,
    int singularPrice,
    DateTime date,
  }) {
    return RoomService(
      serviceId: serviceId ?? this.serviceId,
      quantity: quantity ?? this.quantity,
      singularPrice: singularPrice ?? this.singularPrice,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'quantity': quantity,
      'singularPrice': singularPrice,
      'date': date != null ? Timestamp.fromDate(date) : null,
    };
  }

  factory RoomService.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RoomService(
      serviceId: map['serviceId'],
      quantity: map['quantity'],
      singularPrice: map['singularPrice'],
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomService.fromJson(String source) =>
      RoomService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomService(serviceId: $serviceId, quantity: $quantity, singularPrice: $singularPrice, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomService &&
        o.serviceId == serviceId &&
        o.quantity == quantity &&
        o.singularPrice == singularPrice &&
        o.date == date;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        quantity.hashCode ^
        singularPrice.hashCode ^
        date.hashCode;
  }
}
