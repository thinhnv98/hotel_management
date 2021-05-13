import 'package:bloc/bloc.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/data/responsitory/room_respository.dart';
import 'package:hotel_management/src/data/responsitory/room_session_repository.dart';
import 'package:meta/meta.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository _roomRepository;

  RoomCubit(this._roomRepository) : super(RoomInitial());

  Future<void> loadRooms() async {
    emit(RoomLoading());
    _roomRepository.rooms().listen((e) {
      updateRooms(e);
    });
  }

  Future<void> updateRooms(List<Room> rooms) async {
    try {
      rooms.sort((a, b) => a.name.compareTo(b.name));
      emit(RoomLoaded(listRoom: rooms));
    } catch (e) {
      emit(RoomError(message: e.toString()));
    }
  }

  Future<void> rentRoom(RoomSession roomSession) async {
    try {
      emit(RoomLoading());
      await RoomSessionRepository().addRoomSession(roomSession);
      // final listRoomSession = await _roomSessionRepository.fetchRoomSessions();

      //emit(RoomLoaded(listRoomSession: listRoomSession, listRoom: listRoom));
    } catch (e) {
      emit(RoomError(message: e.toString()));
    }
  }
}
