part of 'room_bill_cubit.dart';

@immutable
abstract class RoomBillState {
  const RoomBillState();
}

class RoomBillInitial extends RoomBillState {
  const RoomBillInitial();
}

class RoomBillLoading extends RoomBillState {
  const RoomBillLoading();
}

class RoomBillLoaded extends RoomBillState {
  final List<RoomSessionBill> listRoomSessionBill;
  const RoomBillLoaded({@required this.listRoomSessionBill});
}

class RoomBillError extends RoomBillState {
  final String message;
  const RoomBillError({this.message});
}
