import 'package:bloc/bloc.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/data/responsitory/room_respository.dart';
import 'package:hotel_management/src/data/responsitory/room_session_repository.dart';
import 'package:meta/meta.dart';

part 'room_session_state.dart';

class RoomSessionCubit extends Cubit<RoomSessionState> {
  final RoomSessionRepository _roomSessionRepository;

  RoomSessionCubit(this._roomSessionRepository) : super(RoomSessionInitial());

  Future<void> loadRoomSessions() async {
    emit(RoomSessionLoading());
    _roomSessionRepository.roomSessions().listen((e) {
      updateRoomSession(e);
    });
  }

  Future<void> updateRoomSession(List<RoomSession> sessions) async {
    try {
      emit(RoomSessionLoaded(roomSessions: sessions));
    } catch (e) {
      emit(RoomSessionError(message: e.toString()));
    }
  }

  Future<void> checkout(RoomSession roomSession, String user) async {
    await _roomSessionRepository.checkout(roomSession, user);
  }

  Future<void> addRoomServices(
      List<RoomService> roomServices, String roomSessionId) async {
    try {
      await _roomSessionRepository.addRoomServices(roomServices, roomSessionId);
      //emit(RoomSessionLoaded(roomSessions: sessions));
    } catch (e) {
      emit(RoomSessionError(message: e.toString()));
    }
  }
}
