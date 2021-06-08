import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/components/initial_service.dart';
import 'package:hotel_management/src/components/service_header.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/screens/booking_screen/booking_screen.dart';
import 'package:hotel_management/src/screens/room_category_screen/widgets/a_e_d_screen.dart';
import 'package:hotel_management/src/screens/room_detail_screen/widgets/room_services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'edit_room_screen.dart';

class RoomScreenBuilder extends StatelessWidget {
  static const String id = "ROOM_DETAIL";
  final Room room;

  const RoomScreenBuilder({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomSessionCubit, RoomSessionState>(
      builder: (context, state) {
        if (state is RoomSessionLoading) {
          return buildRoomDetailLoading();
        } else if (state is RoomSessionLoaded) {
          var roomSession = state.roomSessions.firstWhere(
                  (element) => element.id == room.currentSession,
              orElse: () => null);
          return buildRoomDetailLoaded(key, room, roomSession);
        } else if (state is RoomSessionError) {
          return buildRoomDetailError(state.message);
        }
        return buildRoomDetailInitial(room);
      },
    );
  }
}

Widget buildRoomDetailInitial(Room room) {
  return RoomDetailInitial(
    room: room,
  );
}

Widget buildRoomDetailLoaded(Key key, Room room, RoomSession roomSession) {
  return RoomDetailScreen(
    key: key,
    room: room,
    roomSession: roomSession,
  );
}

Widget buildRoomDetailLoading() {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [CircularProgressIndicator(), Text("Loading room")],
          ),
        ),
      ],
    ),
  );
}

Widget buildRoomDetailError(String message) {
  return Container();
}

class RoomDetailInitial extends StatefulWidget {
  final Room room;

  const RoomDetailInitial({Key key, this.room}) : super(key: key);
  @override
  _RoomDetailInitialState createState() => _RoomDetailInitialState();
}

class _RoomDetailInitialState extends State<RoomDetailInitial> {
  @override
  void initState() {
    super.initState();
    // final roomDetailCubit = RoomDetailCubit(RoomSessionRepository());
    // roomDetailCubit.getRoomDetail(widget.room);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Room Detail Initial"),
    );
  }
}

class RoomDetailScreen extends StatefulWidget {
  static const String id = "ROOM_DETAIL";
  final Room room;
  final RoomSession roomSession;
  // final RoomSessionBill roomBill;

  const RoomDetailScreen({Key key, this.room, this.roomSession})
      : super(key: key);

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  Widget buildNotRented() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Trạng thái',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.green[900]),
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Colors.green[50],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Đang Trống',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[700],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildRented() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Trạng thái',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.red[900]),
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Color(0xFFFFEBF2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Đang Thuê',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFD3C74),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Khách hàng: ' + widget.roomSession.visitorName,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          "Đặt cọc: ${NumberFormat().format(widget.roomSession.prepaid)} VNĐ",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Ghi chú: ' + widget.roomSession.description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.roomSession != null) {
    //   BlocProvider.of<RoomBillCubit>(context).addBill(RoomSessionBill(
    //       roomServiceIds: [], roomSessionId: widget.roomSession.id));
    // }
    return SafeArea(
      child: Scaffold(
        key: _keyScaffold,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(
            "Chi tiết phòng",
            style: TextStyle(color: Colors.black),
          ),
        ),

////////////// Bottom button

//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
//          child: RoomDetailBottom(
//            room: widget.room,
//            roomSession: widget.roomSession,
//            keyScaffold: _keyScaffold,
//          ),
//        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
          child: ListView(
            children: [
              Text(
                widget.room.name,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 12),
              Text(
                widget.room.subtitle,
                style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Constants.kGrayColor),
              ),
              SizedBox(height: 16),
              ServiceHeader(
                tag: widget.room.urlImage,
                urlImageBackground: widget.room.urlImage,
              ),
              SizedBox(height: 32),
              Text(
                'Tiện Nghi',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InitialService(
                        icon: Icons.wifi,
                        serviceName: "Wifi",
                        colors: [Colors.blue[100], Colors.blue[600]],
                      ),
                      InitialService(
                        icon: Icons.ac_unit,
                        serviceName: "AC",
                        colors: [Colors.yellow[100], Colors.yellow[600]],
                      ),
                      InitialService(
                        icon: Icons.tv,
                        serviceName: "TV",
                        colors: [Colors.purple[100], Colors.purple[600]],
                      ),
                      InitialService(
                        icon: Icons.battery_charging_full,
                        serviceName: "Battery",
                        colors: [Colors.pink[100], Colors.pink[300]],
                      ),
                      InitialService(
                        icon: Icons.local_cafe,
                        serviceName: "Coffee",
                        colors: [Colors.pink[100], Colors.pink[300]],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              (widget.roomSession != null) ? buildRented() : buildNotRented(),
              Text(
                'Mô tả',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 12),
              Text(
                widget.room.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              widget.roomSession != null
                  ? RoomServicesBuilder(
                  roomservices: widget.roomSession.roomServices)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

////////////// Bottom Button

//class RoomDetailBottom extends StatelessWidget {
//  final RoomSession roomSession;
//  final Room room;
//  final GlobalKey<ScaffoldState> keyScaffold;
//  bool isShowServices = false;
//
//  RoomDetailBottom({@required this.room, this.roomSession, this.keyScaffold});
//
//  Widget buildRented(
//      {@required Function addCallback,
//        @required Function editCallback}) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: [
//        FlatButton(
//          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
//          child: Text(
//            "Them",
//            style: TextStyle(color: Colors.white),
//          ),
//          color: Colors.green,
//          onPressed: addCallback,
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//        ),
//        FlatButton(
//          child: Text(
//            "Sua",
//            style: TextStyle(color: Colors.white),
//          ),
//          onPressed: editCallback,
//          color: Colors.red[300],
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//        ),
//      ],
//    );
//  }
//
//  Widget buildNotRented(BuildContext context) {
//    return RaisedButton(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(18.0),
//      ),
//      child: SizedBox(
//        width: double.infinity,
//        child: Text(
//          "aaa",
//          style: TextStyle(
//            color: Colors.white,
//          ),
//          textAlign: TextAlign.center,
//        ),
//      ),
//      color: Colors.blue,
//      onPressed: () => Navigator.pushNamed(
//        context,
//        BookingScreen.id,
//        arguments: room,
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return roomSession == null
//        ? buildNotRented(context)
//        : buildRented(
//      addCallback: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => MultiProvider(
//              providers: [
//                Provider<Room>(create: (_) => room),
//                Provider<RoomSession>(create: (_) => roomSession),
//                Provider<GlobalKey<ScaffoldState>>(
//                    create: (_) => keyScaffold),
//              ],
//              child: AddItemForm(),
//            ),
//          ),
//        );
//      },
//      editCallback: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//                edit_Room_screen(roomSession: roomSession, room: room),
//          ),
//        );
//      },
//    );
//  }
//}
