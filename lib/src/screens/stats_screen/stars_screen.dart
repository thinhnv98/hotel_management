import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/cubit/room_bill/room_bill_cubit.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/screens/stats_screen/components/compare_chart.dart';
import 'package:hotel_management/src/screens/stats_screen/models/service_stats_model.dart';
import 'package:intl/intl.dart';

import 'components/detail_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime _startDay;
  DateTime _endDay;
  List<ServiceStatsModel> listServiceStatsModel = [];

  @override
  void initState() {
    final now = DateTime.now();
    _startDay = DateTime(now.year, now.month, 1);
    _endDay = now;
    super.initState();
  }

  double totalServicePrice(RoomSession roomSession, String serviceId) {
    double result = 0;

    final roomSessionServices = roomSession.roomServices;
    roomSessionServices.forEach((roomSessionService) {
      if (roomSessionService.serviceId == serviceId)
        result +=
            (roomSessionService.quantity * roomSessionService.singularPrice)
                .toDouble();
    });
    return result;
  }

  void initData(List<RoomSession> roomSessions) {
    listServiceStatsModel = [];
    roomSessions.forEach(
      (roomSession) {
        if (roomSession.end != null) {
          if (roomSession.end.compareTo(_startDay) != -1 &&
              roomSession.end.compareTo(_endDay) != 1) {
            ServiceStatsModel serviceStatsModel = ServiceStatsModel(
              roomPrice: roomSession.price.toDouble(),
              phonePrice: totalServicePrice(roomSession, phoneServiceId),
              foodPrice: totalServicePrice(roomSession, foodServiceId),
              laundryPrice: totalServicePrice(roomSession, laundryServiceId),
              checkoutDate: roomSession.end,
            );
            listServiceStatsModel.add(serviceStatsModel);
          }
        }
      },
    );
  }

  Widget buildCharts() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
            child: Text(
              "Biểu đồ tổng quan:",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kTextColor,
              ),
            ),
          ),
          CompareChart(listServiceStatsModel),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
            child: Text(
              "Biểu đồ chi tiết:",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kTextColor,
              ),
            ),
          ),
          DetailChart(listServiceStatsModel: listServiceStatsModel),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            "Thinh's Analysis",
            style: TextStyle(
              color: kTextColor,
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
          height: double.infinity,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[50],
                Colors.grey[100],
                Colors.grey[200],
              ],
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: kTextColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Từ ngày: " +
                                  DateFormat("dd-MM-yyyy ").format(_startDay),
                              style: TextStyle(
                                  //decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          _startDay = await showDatePicker(
                                  context: context,
                                  initialDate: _startDay,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101)) ??
                              _startDay;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: kTextColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Đến ngày: " +
                                  DateFormat("dd-MM-yyyy ").format(_endDay),
                              style: TextStyle(
                                  //color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          _endDay = await showDatePicker(
                                  context: context,
                                  initialDate: _endDay,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101)) ??
                              _endDay;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      100 -
                      AppBar().preferredSize.height,
                  child: ListView(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: <Widget>[
                      //       GestureDetector(
                      //         child: Row(
                      //           children: <Widget>[
                      //             Icon(
                      //               Icons.calendar_today,
                      //               color: kTextColor,
                      //             ),
                      //             SizedBox(width: 5),
                      //             Text(
                      //               "Từ ngày: " +
                      //                   DateFormat("dd-MM-yyyy ")
                      //                       .format(_startDay),
                      //               style: TextStyle(
                      //                   //decoration: TextDecoration.underline,
                      //                   ),
                      //             ),
                      //           ],
                      //         ),
                      //         onTap: () async {
                      //           _startDay = await showDatePicker(
                      //                   context: context,
                      //                   initialDate: _startDay,
                      //                   firstDate: DateTime(2015, 8),
                      //                   lastDate: DateTime(2101)) ??
                      //               _startDay;
                      //           setState(() {});
                      //         },
                      //       ),
                      //       GestureDetector(
                      //         child: Row(
                      //           children: <Widget>[
                      //             Icon(
                      //               Icons.calendar_today,
                      //               color: kTextColor,
                      //             ),
                      //             SizedBox(width: 5),
                      //             Text(
                      //               "Đến ngày: " +
                      //                   DateFormat("dd-MM-yyyy ").format(_endDay),
                      //               style: TextStyle(
                      //                   //color: Colors.blue,
                      //                   //decoration: TextDecoration.underline,
                      //                   ),
                      //             ),
                      //           ],
                      //         ),
                      //         onTap: () async {
                      //           _endDay = await showDatePicker(
                      //                   context: context,
                      //                   initialDate: _endDay,
                      //                   firstDate: DateTime(2015, 8),
                      //                   lastDate: DateTime(2101)) ??
                      //               _endDay;
                      //           setState(() {});
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      BlocBuilder<RoomSessionCubit, RoomSessionState>(
                        builder: (context, state) {
                          if (state is RoomSessionLoading) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: SimpleDialog(
                                backgroundColor: Colors.black54,
                                children: <Widget>[
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Loading...",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else if (state is RoomSessionLoaded) {
                            var roomSessions = state.roomSessions;
                            initData(roomSessions);
                            return buildCharts();
                          } else if (state is RoomSessionError) {
                            return Center(
                              child: Container(
                                child: Text("Something went wrong!"),
                              ),
                            );
                          }
                          return Center(
                            child: Container(
                              child: Text("No room sessions."),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
