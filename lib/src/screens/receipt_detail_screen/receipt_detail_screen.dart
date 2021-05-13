import 'package:flutter/material.dart';
import 'package:hotel_management/src/components/initial_service.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/screens/room_detail_screen/widgets/room_service_item.dart';
import 'package:intl/intl.dart';

class ReceiptDetail extends StatefulWidget {
  final RoomSessionBill roomSessionBill;

  const ReceiptDetail({Key key, this.roomSessionBill}) : super(key: key);
  @override
  _ReceiptDetailState createState() => _ReceiptDetailState();
}

class _ReceiptDetailState extends State<ReceiptDetail> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Color(0xFFE8EDF5),
    //   appBar: AppBar(
    //     title: Text('Chi tiết hóa đơn'),
    //   ),
    //   body: Container(
    //     child: SingleChildScrollView(
    //       physics: ScrollPhysics(),
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 40, right: 12, left: 12),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             InfoReceiptDetail(
    //               roomSessionBill: widget.roomSessionBill,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 20),
    //               child: Text("Chi tiết"),
    //             ),
    //             DetailReceipt(
    //               roomSessionBill: widget.roomSessionBill,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
        backgroundColor: Color(0xFFF8F9FA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Hóa đơn",
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
                Text("175 Đường 2, Quận 9, TP. Thủ Đức, HCM"),
                Text(
                  DateFormat("hh:mm a   dd-MM-yyyy")
                      .format(widget.roomSessionBill.roomSession.start),
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
            "Khách hàng: " +
                widget.roomSessionBill.roomSession.visitorName.toUpperCase(),
            style: TextStyle(letterSpacing: 2),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phòng: " + widget.roomSessionBill.roomSession.roomName,
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
                "Giá : " +
                    NumberFormat()
                        .format(widget.roomSessionBill.roomSession.price) +
                    " VNĐ",
                style: TextStyle(letterSpacing: 1),
              ),
              Text(
                "Thời gian thuê: " +
                    (widget.roomSessionBill.time
                                .difference(
                                    widget.roomSessionBill.roomSession.start)
                                .inDays +
                            1)
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
            "Tiền phòng: " +
                NumberFormat().format(widget.roomSessionBill.roomSession.price *
                    (widget.roomSessionBill.time
                            .difference(
                                widget.roomSessionBill.roomSession.start)
                            .inDays +
                        1)) +
                " VNĐ",
            style: TextStyle(letterSpacing: 1),
          ),
          SizedBox(
            height: 6,
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
            widget.roomSessionBill.roomSession.roomServices != null
                ? ListView.builder(
                    itemBuilder: (context, index) => RoomServiceItem(
                      roomService: widget
                          .roomSessionBill.roomSession.roomServices[index],
                    ),
                    itemCount:
                        widget.roomSessionBill.roomSession.roomServices.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  )
                : Container(),
            // ...(roomServices.map((e) => RoomServiceItem(service: e)).toList()),
            Divider(color: Colors.grey),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng tiền : ",
                  style: TextStyle(letterSpacing: 1),
                ),
                Text(
                  '${NumberFormat().format(widget.roomSessionBill.roomSession.totalMoney() + widget.roomSessionBill.roomSession.prepaid)} VNĐ',
                  style: TextStyle(letterSpacing: 1),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tạm ứng : ",
                  style: TextStyle(letterSpacing: 1),
                ),
                Text(
                  '${NumberFormat().format(widget.roomSessionBill.roomSession.prepaid)} VNĐ',
                  style: TextStyle(letterSpacing: 1),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thanh toán : ",
                  style: TextStyle(letterSpacing: 1),
                ),
                Text(
                  '${NumberFormat().format(widget.roomSessionBill.roomSession.totalMoney())} VNĐ',
                  style: TextStyle(letterSpacing: 1),
                )
              ],
            ),

            // Text('${sum.toString()}\$',
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline3
            //         .copyWith(color: Colors.green)),
          ]),
        ],
      ),
    );
  }
}

class DetailReceipt extends StatelessWidget {
  final RoomSessionBill roomSessionBill;

  const DetailReceipt({
    Key key,
    this.roomSessionBill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0xFFF8FAFF)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            roomSessionBill.roomSession.roomServices != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RoomServiceItem(
                      roomService:
                          roomSessionBill.roomSession.roomServices[index],
                    ),
                    itemCount: roomSessionBill.roomSession.roomServices.length,
                    physics: ScrollPhysics(),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng tiền"),
                Text("${roomSessionBill.total}\$"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoReceiptDetail extends StatelessWidget {
  final RoomSessionBill roomSessionBill;

  const InfoReceiptDetail({
    Key key,
    this.roomSessionBill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0xFFF8FAFF)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InitialService(
              colors: [Colors.blue[200], Colors.blue[600]],
              icon: Icons.av_timer,
              serviceName: DateFormat("dd-MM-yyyy")
                  .format(roomSessionBill.time)
                  .toString(),
            ),
            Text(
              roomSessionBill.roomSession.roomName,
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InitialService(
                      colors: [Colors.blue[200], Colors.blue[600]],
                      icon: Icons.receipt,
                      serviceName: "",
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(roomSessionBill.roomSession.visitorName),
                        SizedBox(
                          height: 20,
                        ),
                        Text(roomSessionBill.employee),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
