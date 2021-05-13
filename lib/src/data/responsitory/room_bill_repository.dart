import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/data/responsitory/room_session_repository.dart';
import 'package:hotel_management/src/data/responsitory/service_repository.dart';

class RoomSessionBillRepository {
  final roomSessionBillCollection =
      FirebaseFirestore.instance.collection('session_bills');
  Future<List<RoomSessionBill>> fetchRoomBills() {
    return roomSessionBillCollection.get().then(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => RoomSessionBill.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<RoomSessionBill>> roomSessionBills() {
    // return roomSessionCollection.snapshots().asyncMap((snapshot) async =>
    //     await Future.wait(
    //         snapshot.docs.map((doc) async => RoomSession.fromSnapshot(doc))));

    return roomSessionBillCollection.snapshots().map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              var roomSessionBill = RoomSessionBill.fromMap(doc.data());

              FirebaseFirestore.instance
                  .collection("room_sessions")
                  .doc(doc.data()['sessionId'])
                  .get()
                  .then(
                (value) {
                  var roomSession = RoomSession.fromMap(
                    value.data(),
                  );
                  roomSessionBill.copyWith(roomSession: roomSession);
                },
              );
              return roomSessionBill;
            },
          ).toList(),
        );
  }

  Future<List<RoomSessionBill>> addRoomBill(RoomSessionBill roomBill) {}
}
