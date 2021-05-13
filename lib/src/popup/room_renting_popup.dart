import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/room/room_cubit.dart';
import 'package:hotel_management/src/cubit/room_bill/room_bill_cubit.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:intl/intl.dart';

class RoomRentingPopup extends StatelessWidget {
  final Image roomImage;
  final String roomName;
  final String roomUrl;
  final String roomId;
  final int price;
  final String visitorName;
  final Duration rentDuration;
  final int prepaid;
  final String description;
  final Function confirmCallback;

  RoomRentingPopup({
    @required this.roomId,
    @required this.roomName,
    @required this.roomImage,
    @required this.visitorName,
    @required this.rentDuration,
    @required this.prepaid,
    @required this.description,
    @required this.confirmCallback,
    this.price,
    this.roomUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Xác nhận thuê phòng')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          roomImage,
          Center(child: Text(roomName)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Khách: ' + visitorName),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Ngày đặt phòng: ' +
                DateFormat("dd-MM-yyyy ").format(DateTime.now())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Giờ đặt phòng: ' +
                DateFormat("hh:mm a").format(DateTime.now())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:
                Text('Trả trước: ' + NumberFormat().format(prepaid) + ' VNĐ'),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            'Hủy',
            style: TextStyle(color: Colors.black38),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Xác nhận"),
          onPressed: () {
            BlocProvider.of<RoomCubit>(context).rentRoom(RoomSession(
              description: description,
              prepaid: prepaid,
              price: price,
              roomId: roomId,
              roomUrl: roomUrl,
              roomName: roomName,
              start: DateTime.now(),
              visitorName: visitorName,
            ));
            Navigator.pop(context);
            confirmCallback();
          },
        ),
      ],
    );
  }
}
