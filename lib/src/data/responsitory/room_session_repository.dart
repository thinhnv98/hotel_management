import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';

class RoomSessionRepository {
  final roomSessionCollection =
      FirebaseFirestore.instance.collection('room_sessions');

  // Future<List<RoomSession>> fetchRoomSessions() async {
  //   return roomSessionCollection.get().then(
  //         (querySnapshot) => querySnapshot.docs
  //             .map(
  //               (e) => RoomSession.fromMap(
  //                 e.data(),
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

  Stream<List<RoomSession>> roomSessions() {
    // return roomSessionCollection.snapshots().asyncMap((snapshot) async =>
    //     await Future.wait(
    //         snapshot.docs.map((doc) async => RoomSession.fromSnapshot(doc))));

    return roomSessionCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => RoomSession.fromMap(doc.data())).toList());
  }

  // Stream<RoomSession> roomSession(String sessionId) {
  //   return roomSessionCollection
  //       .doc(sessionId)
  //       .snapshots()
  //       .asyncMap((snapshot) => RoomSession.fromMap(snapshot.data()));
  // }

  // Future<RoomSession> getSessionDetail(String sessionId) async {
  //   if (sessionId == null) return null;
  //   var data = await roomSessionCollection
  //       .doc(sessionId)
  //       .get()
  //       .then((snapshot) async => RoomSession.fromSnapshot(snapshot));
  //   return data;
  // }

  Future addRoomSession(RoomSession roomSession) async {
    try {
      await roomSessionCollection.add(roomSession.toMap()).then((docRef) async {
        docRef.update({"id": docRef.id});
        roomSession.roomServices?.forEach((e) {
          docRef.collection("session_services").add(e.toMap());
        });
        await FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomSession.roomId)
            .update({"currentSession": docRef.id});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addRoomServices(
      List<RoomService> roomServices, String roomSessionId) async {
    try {
      await roomSessionCollection.doc(roomSessionId).set(
        {
          "roomServices": FieldValue.arrayUnion(
            roomServices.map((roomService) => roomService.toMap()).toList(),
          ),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<RoomSession> getRoomSessionById(String id) {
    return roomSessionCollection.doc(id).get().then(
          (value) => RoomSession.fromMap(
            value.data(),
          ),
        );
  }

  Future<void> checkout(RoomSession roomSession, String employee) async {
    try {
      await roomSessionCollection.doc(roomSession.id).update(<String, dynamic>{
        'end': DateTime.now(),
      }).then((docRef) async {
        await FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomSession.roomId)
            .update({"currentSession": null});
        await FirebaseFirestore.instance
            .collection("session_bills")
            .add(new RoomSessionBill(
                    employee: employee,
                    sessionId: roomSession.id,
                    time: DateTime.now(),
                    total: roomSession.totalMoney())
                .toMap())
            .then((value) => value.update({'id': value.id}));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
