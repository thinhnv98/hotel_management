import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/room/room_cubit.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/screens/home_screen/home_screen.dart';
import 'package:hotel_management/src/screens/room_detail_screen/widgets/room_service_item.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatelessWidget {
  final RoomSession roomSession;
  final Room room;
  CheckoutScreen({@required this.roomSession, @required this.room});

  @override
  Widget build(BuildContext context) {
    int price =
        (DateTime.now().difference(roomSession.start).inDays + 1) * room.price;

    print(roomSession);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
        backgroundColor: Color(0xFFF8F9FA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Trả Phòng",
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
          },
        ),
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: roomServices.length,
      //         itemBuilder: (context, index) {
      //           return RoomServiceItem(
      //             service: roomServices[index],
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/hotel@2x.png"),
                  height: 80,
                ),
                Text("Khách sạn NT118.L21"),
                Text("175 Đường 2, Quận 9, HCM"),
                Text(
                  DateFormat("hh:mm a   dd-MM-yyyy").format(roomSession.start),
                  style: TextStyle(letterSpacing: 2),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Text(
            "THÔNG TIN PHÒNG",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Khách hàng: " + roomSession.visitorName.toUpperCase(),
            style: TextStyle(letterSpacing: 2),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phòng: " + roomSession.roomName,
                style: TextStyle(letterSpacing: 2),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Giá : " + NumberFormat().format(roomSession.price) + " VNĐ",
                style: TextStyle(letterSpacing: 1),
              ),
              Text(
                "Thời gian thuê: " +
                    (DateTime.now().difference(roomSession.start).inDays + 1)
                        .toString() +
                    " ngày",
                style: TextStyle(letterSpacing: 1),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "Tiền phòng: " + NumberFormat().format(price) + " VNĐ",
            style: TextStyle(letterSpacing: 1),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "Tạm ứng: " + NumberFormat().format(roomSession.prepaid) + " VNĐ",
            style: TextStyle(letterSpacing: 1),
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            "DỊCH VỤ THÊM",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w200),
          ),
          Column(children: [
            roomSession.roomServices != null
                ? ListView.builder(
                    itemBuilder: (context, index) => RoomServiceItem(
                      roomService: roomSession.roomServices[index],
                    ),
                    itemCount: roomSession.roomServices.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  )
                : Container(),
            // ...(roomServices.map((e) => RoomServiceItem(service: e)).toList()),
            Divider(color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Tổng tiền',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.w300),
            ),
            Text('${NumberFormat().format(roomSession.totalMoney())} VNĐ',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.green)),
            // Text('${sum.toString()}\$',
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline3
            //         .copyWith(color: Colors.green)),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CheckoutButton(roomSession: roomSession),
          ),
        ],
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key key,
    @required this.roomSession,
  }) : super(key: key);

  final RoomSession roomSession;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context
            .bloc<RoomSessionCubit>()
            .checkout(roomSession, "Nguyễn Văn Thịnh");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Trả phòng thành công"),
          backgroundColor: Colors.green[500],
        ));
        Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent[100],
              Colors.green,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Xác nhận',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
