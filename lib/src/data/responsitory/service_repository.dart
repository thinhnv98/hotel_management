import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/src/data/model/service_model.dart';

class ServiceRepository {
  Future<List<Service>> fetchListService() {
    return FirebaseFirestore.instance.collection('services').get().then(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => Service.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
