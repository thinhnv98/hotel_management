import 'package:flutter/material.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/screens/service_booking_screen/service_booking_screen.dart';
import 'package:provider/provider.dart';

class ServiceSubmitButton extends StatelessWidget {
  const ServiceSubmitButton({
    Key key,
    @required this.tempServices,
  }) : super(key: key);

  final List<RoomService> tempServices;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Color.fromARGB(255, 116, 69, 214),
          ],
        ),
        //borderRadius: BorderRadius.all(Radius.circular(80.0)),
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        onPressed: () {
          final Room room = Provider.of<Room>(context, listen: false);
          final RoomSession roomSession =
              Provider.of<RoomSession>(context, listen: false);
          final GlobalKey<ScaffoldState> keyscaffold =
              Provider.of<GlobalKey<ScaffoldState>>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceBookingScreen(
                  roomServices: tempServices,
                  room: room,
                  onCheckOutSuccessfully: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    keyscaffold.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blueAccent,
                        content: Row(
                          children: [
                            Icon(Icons.info),
                            SizedBox(width: 20),
                            Text("Đặt dịch vụ thành công"),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Text(
            'Đặt dịch vụ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
