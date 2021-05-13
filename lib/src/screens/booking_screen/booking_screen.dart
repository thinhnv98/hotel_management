import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/components/info_card.dart';
import 'package:hotel_management/src/components/service_header.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/popup/room_renting_popup.dart';
import 'package:hotel_management/src/screens/home_screen/all_rooms_page.dart';
import 'package:hotel_management/src/screens/home_screen/home_screen.dart';

class BookingScreen extends StatefulWidget {
  static const String id = "BOOKING";

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController visitorName = TextEditingController();
  TextEditingController rentingTime = TextEditingController();
  TextEditingController prepaid = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;

    TextEditingController dateCtl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Đặt phòng",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "Xác nhận",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          color: Colors.green,
          onPressed: () {
            if (_formkey.currentState.validate()) {
              showDialog(
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: RoomRentingPopup(
                    roomImage: Image.network(room.urlImage),
                    prepaid: int.parse(prepaid.value.text),
                    rentDuration: Duration(days: 2),
                    roomName: room.name,
                    visitorName: visitorName.value.text,
                    description: description.value.text,
                    roomId: room.id,
                    roomUrl: room.urlImage,
                    price: room.price,
                    confirmCallback: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: ListView(
          children: [
            Text(
              room.name,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              room.subtitle,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Constants.kGrayColor),
            ),
            SizedBox(height: 18),
            ServiceHeader(
              tag: "random",
              urlImageBackground: room.urlImage,
            ),
            SizedBox(height: 28),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelText: "Tên khách",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return 'Vui lòng nhập thông tin';
                      return null;
                    },
                    controller: visitorName,
                  ),
                  // SizedBox(height: 20),
                  // TextFormField(
                  //   decoration: new InputDecoration(
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     labelText: "Thời gian thuê",
                  //     fillColor: Colors.white,
                  //     border: new OutlineInputBorder(
                  //       borderRadius: new BorderRadius.circular(10.0),
                  //       borderSide: new BorderSide(),
                  //     ),
                  //   ),
                  //   keyboardType: TextInputType.number,
                  //   validator: (value) {
                  //     if (value.isEmpty) return 'Vui lòng nhập thông tin';
                  //     return null;
                  //   },
                  //   controller: rentingTime,
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     TextFormField(
                  //       controller: dateCtl,
                  //       // decoration: InputDecoration(
                  //       //   labelText: "",
                  //       //   hintText: "",
                  //       // ),
                  //       onTap: () async {
                  //         DateTime date = DateTime(1900);
                  //         FocusScope.of(context)
                  //             .requestFocus(new FocusNode());
                  //         date = await showDatePicker(
                  //             context: context,
                  //             initialDate: DateTime.now(),
                  //             firstDate: DateTime(1900),
                  //             lastDate: DateTime(2100));

                  //         dateCtl.text = date.toIso8601String();
                  //       },
                  //     )
                  //   ],
                  // ),
                  // InputDatePickerFormField(
                  //   firstDate: DateTime(1900),
                  //   lastDate: DateTime(2100),
                  //   autofocus: true,
                  //   selectableDayPredicate: ,
                  // ),
                  // TextFormField(
                  //   controller: dateCtl,
                  //   decoration: InputDecoration(
                  //     labelText: "",
                  //     hintText: "",
                  //   ),
                  //   onTap: () async {
                  //     DateTime date = DateTime(1900);
                  //     FocusScope.of(context).requestFocus(new FocusNode());
                  //     date = await showDatePicker(
                  //         context: context,
                  //         initialDate: DateTime.now(),
                  //         firstDate: DateTime(1900),
                  //         lastDate: DateTime(2100));
                  //     if (date != null) {
                  //       setState(() {
                  //         dateCtl.text = date.toIso8601String();
                  //         print(dateCtl.text);
                  //       });
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelText: "Tiền đặt cọc",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) return 'Vui lòng nhập thông tin';
                      return null;
                    },
                    controller: prepaid,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    maxLines: null,
                    decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      labelText: "Diễn giải",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    controller: description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
