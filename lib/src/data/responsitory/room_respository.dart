import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/src/data/model/room_model.dart';

class RoomRepository {
  CollectionReference roomsCollection =
      FirebaseFirestore.instance.collection('rooms');

  Future<List<Room>> fetchListRoom() async {
    return FirebaseFirestore.instance.collection('rooms').get().then(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => Room.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Room>> rooms() {
    return roomsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Room.fromMap(doc.data())).toList());
  }

  Future<List<Room>> getRoom(Room room) async {
    return FirebaseFirestore.instance.collection('rooms').get().then(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => Room.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
