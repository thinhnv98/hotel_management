part of 'room_cubit.dart';

@immutable
abstract class RoomState {
  const RoomState();
}

class RoomInitial extends RoomState {
  const RoomInitial();
}

class RoomLoading extends RoomState {
  const RoomLoading();
}

class RoomLoaded extends RoomState {
  final List<Room> listRoom;
  const RoomLoaded({@required this.listRoom});
}

class RoomError extends RoomState {
  final String message;
  const RoomError({this.message});
}
