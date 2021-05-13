import 'dart:convert';

class Room {
  final String id;
  final String name;
  final String subtitle;
  final String description;
  final String urlImage;

  final String currentSession;
  final int price;

  Room({
    this.id,
    this.name,
    this.subtitle,
    this.description,
    this.urlImage,
    this.currentSession,
    this.price,
  });

  Room copyWith({
    String id,
    String name,
    String subtitle,
    String description,
    String urlImage,
    String currentSession,
    int price,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      urlImage: urlImage ?? this.urlImage,
      currentSession: currentSession ?? this.currentSession,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'description': description,
      'urlImage': urlImage,
      'currentSession': currentSession,
      'price': price,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Room(
      id: map['id'],
      name: map['name'],
      subtitle: map['subtitle'],
      description: map['description'],
      urlImage: map['urlImage'],
      currentSession: map['currentSession'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Room(id: $id, name: $name, subtitle: $subtitle, description: $description, urlImage: $urlImage, currentSession: $currentSession, price: $price)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Room &&
        o.id == id &&
        o.name == name &&
        o.subtitle == subtitle &&
        o.description == description &&
        o.urlImage == urlImage &&
        o.currentSession == currentSession &&
        o.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        subtitle.hashCode ^
        description.hashCode ^
        urlImage.hashCode ^
        currentSession.hashCode ^
        price.hashCode;
  }
}
