import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/src/cubit/service/service_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/service_model.dart';
import 'package:hotel_management/src/screens/room_detail_screen/widgets/room_service_item.dart';
import 'package:intl/intl.dart';

class RoomServicesBuilder extends StatelessWidget {
  final List<RoomService> roomservices;

  RoomServicesBuilder({this.roomservices});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        if (state is ServiceInitial) {
          return buildRoomServicesInitial();
        } else if (state is ServiceLoading) {
          return buildRoomServicesLoading();
        } else if (state is ServiceLoaded) {
          return RoomServices(state.listService, listRoomService: roomservices);
        } else
          return buildRoomServicesError();
      },
    );
  }
}

buildRoomServicesInitial() {
  return RoomServicesInitial();
}

buildRoomServicesLoading() {
  return Container(
    padding: EdgeInsets.only(top: 50),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 25),
        Text('Loading Services'),
      ],
    ),
  );
}

buildRoomServicesLoaded(List<Service> services) {
  return RoomServices(services);
}

buildRoomServicesError() {
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      child: Text('Cannot load any service'),
    ),
  );
}

class RoomServicesInitial extends StatefulWidget {
  @override
  _RoomServicesInitialState createState() => _RoomServicesInitialState();
}

class _RoomServicesInitialState extends State<RoomServicesInitial> {
  @override
  void initState() {
    final serviceCubit = context.bloc<ServiceCubit>();
    serviceCubit.getListService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 25),
          Text('Loading Services'),
        ],
      ),
    );
  }
}

class RoomServices extends StatefulWidget {
  final List<Service> serviceModels;
  final List<RoomService> listRoomService;
  RoomServices(this.serviceModels, {this.listRoomService});

  @override
  _RoomServicesState createState() => _RoomServicesState();
}

List<Widget> buildServices(List<RoomService> services) {
  // List<Widget>.generate(
  //         widget.listRoomService.length,
  //         (index) =>
  //             RoomServiceItem(roomService: widget.listRoomService[index]),
  //       ),
  services = services.reversed.toList();
  List<Widget> widgets = List<Widget>();
  bool newDate = true;
  for (int i = 0; i < services.length; ++i) {
    print(services[i].date.minute);
    if (i == 0 ||
        services[i].date.day != services[i - 1].date.day ||
        services[i].date.month != services[i - 1].date.month ||
        services[i].date.year != services[i - 1].date.year) {
      newDate = true;
      widgets.add(SizedBox(height: 28));
      widgets.add(Text(
          "⚬ Ngày " + DateFormat("dd-MM-yyyy").format(services[i].date),
          style: TextStyle(fontSize: 18)));
    } else if (i > 0 && services[i].date.hour != services[i - 1].date.hour ||
        services[i].date.minute != services[i - 1].date.minute) {
      widgets.add(Divider());

      widgets.add(Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          DateFormat("hh:mm a").format(services[i].date),
          style: TextStyle(color: Colors.grey),
        ),
      ));
    }
    if (newDate) {
      widgets.add(Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          DateFormat("hh:mm a").format(services[i].date),
          style: TextStyle(color: Colors.grey),
        ),
      ));
    }
    widgets.add(RoomServiceItem(roomService: services[i]));
    newDate = false;
  }
  return widgets;
}

class _RoomServicesState extends State<RoomServices> {
  @override
  void initState() {
    super.initState();
  }

  // Future<List<RoomService>> loadRooms() async {
  //   List<RoomService> services = [];
  //   await Future.forEach(widget.roomSessionBill.roomServiceIds,
  //       (roomSessionId) async {
  //     var roomService = await FirebaseFirestore.instance
  //         .collection('room_services')
  //         .doc(roomSessionId)
  //         .get()
  //         .then(
  //           (snapshot) => RoomService.fromMap(
  //             snapshot.data(),
  //           ),
  //         );
  //     services.add(roomService);
  //   });

  //   return services;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.listRoomService == null || widget.listRoomService.length == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text("Chưa đặt dịch vụ nào"),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dịch vụ đã đặt',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(height: 16),
        // ...List<Widget>.generate(
        //   widget.listRoomService.length,
        //   (index) =>
        //       RoomServiceItem(roomService: widget.listRoomService[index]),
        // ),
        ...buildServices(widget.listRoomService),
      ],
    );
    // FutureBuilder(
    //   future: loadRooms(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else {
    //       return snapshot.hasData
    //           ? Column(
    //               children: List<Widget>.generate(
    //                 snapshot.data.length,
    //                 (index) =>
    //                     RoomServiceItem(roomService: snapshot.data[index]),
    //               ),
    //             )
    //           : Container();
    //     }
    //   },
    // );
  }
}
