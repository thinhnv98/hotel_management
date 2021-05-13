import 'package:bloc/bloc.dart';
import 'package:hotel_management/src/data/responsitory/room_session_repository.dart';
import 'package:meta/meta.dart';

import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/responsitory/room_bill_repository.dart';

part 'room_bill_state.dart';

class RoomBillCubit extends Cubit<RoomBillState> {
  final RoomSessionBillRepository _roomBillRepository;

  RoomBillCubit(this._roomBillRepository) : super(RoomBillInitial());

  // Future<void> getListRoomBill() async {
  //   try {
  //     emit(RoomBillLoading());
  //     final listRoomSessionBill = await _roomBillRepository.fetchRoomBills();
  //     emit(RoomBillLoaded(listRoomSessionBill: listRoomSessionBill));
  //   } catch (e) {
  //     emit(RoomBillError(message: e.toString()));
  //   }
  // }

  Future<void> loadRoomSessionBills() async {
    emit(RoomBillLoading());
    _roomBillRepository.roomSessionBills().listen((e) async {
      await Future.forEach(
          e,
          (element) async => element.roomSession = await RoomSessionRepository()
              .getRoomSessionById(element.sessionId));

      updateRoomSessionBills(e);
    });
  }

  Future<void> updateRoomSessionBills(List<RoomSessionBill> sessions) async {
    try {
      emit(RoomBillLoaded(listRoomSessionBill: sessions));
    } catch (e) {
      emit(RoomBillError(message: e.toString()));
    }
  }

  Future<void> addBill(RoomSessionBill roomSessionBill) async {
    try {
      emit(RoomBillLoading());
      final listRoomSessionBill =
          await _roomBillRepository.addRoomBill(roomSessionBill);
      emit(RoomBillLoaded(listRoomSessionBill: listRoomSessionBill));
    } catch (e) {
      emit(RoomBillError(message: e.toString()));
    }
  }
}
