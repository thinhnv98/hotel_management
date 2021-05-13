part of 'room_session_cubit.dart';

@immutable
abstract class RoomSessionState {
  const RoomSessionState();
}

class RoomSessionInitial extends RoomSessionState {}

class RoomSessionLoading extends RoomSessionState {}

class RoomSessionLoaded extends RoomSessionState {
  final List<RoomSession> roomSessions;
  const RoomSessionLoaded({@required this.roomSessions});
}

class RoomSessionError extends RoomSessionState {
  final String message;
  const RoomSessionError({this.message});
}
