import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:intl/intl.dart';

import 'components/service_booking_item.dart';

class ServiceBookingScreen extends StatelessWidget {
  final List<RoomService> roomServices;
  final Room room;
  final Function onCheckOutSuccessfully;

  const ServiceBookingScreen(
      {Key key, this.roomServices, this.room, this.onCheckOutSuccessfully})
      : super(key: key);

  double totalPrice() {
    double result = 0;
    roomServices.forEach((service) {
      result += service.singularPrice * service.quantity;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[50],
                Colors.grey[100],
                Colors.grey[200],
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFF8F9FA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Đặt dịch vụ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[50],
              Colors.grey[100],
              Colors.grey[200],
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phòng:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Ngày:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Nhân viên:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm a').format(dateTime),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Nguyễn Văn Thịnh",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey[600],
                  thickness: 0.6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DỊCH VỤ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "ĐƠN GIÁ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            "THÀNH TIỀN",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                  thickness: 0.6,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          40) *
                      0.55,
                  child: ListView(
                    children: roomServices
                        .map(
                          (e) => ServiceBookingItem(
                            roomService: e,
                            color: (roomServices.indexOf(e) % 2 == 0)
                                ? Colors.white
                                : Colors.grey[200],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 0.8,
                ),
                // SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền :',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.grey[700]),
                    ),
                    Text(
                      '${NumberFormat().format(totalPrice()).toString()} VNĐ',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.deepPurple),
                    )
                  ],
                ),
                // SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Color.fromARGB(255, 116, 69, 214),
                      ],
                    ),
                  ),
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    onPressed: () async {
                      roomServices.forEach((roomService) {
                        roomService.date = dateTime;
                      });
                      try {
                        await BlocProvider.of<RoomSessionCubit>(context)
                            .addRoomServices(roomServices, room.currentSession);
                        onCheckOutSuccessfully();
                      } catch (e) {}
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Xác nhận',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //     width: double.infinity,
                //     margin: EdgeInsets.symmetric(horizontal: 30),
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [
                //           Colors.blueAccent,
                //           Color.fromARGB(255, 116, 69, 214),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.all(Radius.circular(80.0)),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 12.0),
                //       child: Text(
                //         'Xác nhận',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
