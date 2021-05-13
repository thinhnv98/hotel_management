import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/auth_firebase.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/components/initial_service.dart';
import 'package:hotel_management/src/cubit/room_bill/room_bill_cubit.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/data/model/room_bill.dart';
import 'package:hotel_management/src/data/model/room_session_model.dart';
import 'package:hotel_management/src/screens/login_screen/login_screen.dart';
import 'package:hotel_management/src/screens/receipt_detail_screen/receipt_detail_screen.dart';
import 'package:hotel_management/src/screens/stats_screen/stars_screen.dart';
import 'package:intl/intl.dart';

class ReceiptScreenBuilder extends StatelessWidget {
  static const String id = "LIST_RECEIPT";

  const ReceiptScreenBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBillCubit, RoomBillState>(
      builder: (context, state) {
        if (state is RoomBillLoading) {
          return buildReceiptLoading();
        } else if (state is RoomBillLoaded) {
          // var roomSession = state.listRoomSessionBill.firstWhere(
          //     (element) => element.id == room.currentSession,
          //     orElse: () => null);
          return buildReceiptLoaded(key, state.listRoomSessionBill);
        } else if (state is RoomBillError) {
          return buildReceiptError(state.message);
        }
        return buildReceiptInitial();
      },
    );
  }
}

Widget buildReceiptInitial() {
  return ReceiptInitial();
}

Widget buildReceiptLoaded(Key key, List<RoomSessionBill> listRoomSessionBills) {
  return ReceiptScreen(
    listRoomSessionBills: listRoomSessionBills,
  );
}

Widget buildReceiptLoading() {
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

Widget buildReceiptError(String message) {
  return Container();
}

class ReceiptInitial extends StatefulWidget {
  const ReceiptInitial({Key key}) : super(key: key);
  @override
  _ReceiptInitialState createState() => _ReceiptInitialState();
}

class _ReceiptInitialState extends State<ReceiptInitial> {
  @override
  void initState() {
    super.initState();
    // final ReceiptCubit = ReceiptCubit(RoomSessionRepository());
    // ReceiptCubit.getReceipt(widget.room);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Room Detail Initial"),
    );
  }
}

class ReceiptScreen extends StatefulWidget {
  final List<RoomSessionBill> listRoomSessionBills;

  const ReceiptScreen({Key key, this.listRoomSessionBills}) : super(key: key);
  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

List<Widget> buildServices(List<RoomSessionBill> services) {
  services.sort((a, b) => b.time.compareTo(a.time));
  List<Widget> widgets = List<Widget>();
  for (int i = 0; i < services.length; ++i) {
    if (i == 0 ||
        services[i].time.day != services[i - 1].time.day ||
        services[i].time.month != services[i - 1].time.month ||
        services[i].time.year != services[i - 1].time.year) {
      int total = 0;
      for (int j = 0; j < services.length; ++j) {
        if (services[i].time.day == services[j].time.day &&
            services[i].time.month == services[j].time.month &&
            services[i].time.year == services[j].time.year) {
          total += services[j].total;
        }
      }
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(DateFormat("dd-MM-yyyy").format(services[i].time),
                      style: TextStyle(color: Colors.red[900])),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Tổng tiền:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[50],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(NumberFormat().format(total) + "VNĐ",
                          style: TextStyle(color: Colors.green[900])),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
    }
    widgets.add(ReceiptItem(roomSession: services[i]));
  }
  return widgets;
}

List<Widget> buildPrepaidBills(List<RoomSession> roomSessions) {
  roomSessions.sort((a, b) => b.start.compareTo(a.start));
  List<Widget> widgets = List<Widget>();
  for (int i = 0; i < roomSessions.length; ++i) {
    if (i == 0 ||
        roomSessions[i].start.day != roomSessions[i - 1].start.day ||
        roomSessions[i].start.month != roomSessions[i - 1].start.month ||
        roomSessions[i].start.year != roomSessions[i - 1].start.year) {
      int total = 0;
      for (int j = 0; j < roomSessions.length; ++j) {
        if (roomSessions[i].start.day == roomSessions[j].start.day &&
            roomSessions[i].start.month == roomSessions[j].start.month &&
            roomSessions[i].start.year == roomSessions[j].start.year) {
          total += roomSessions[j].prepaid;
        }
      }
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      DateFormat("dd-MM-yyyy").format(roomSessions[i].start),
                      style: TextStyle(color: Colors.red[900])),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Tổng tiền:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[50],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(NumberFormat().format(total) + "VNĐ",
                          style: TextStyle(color: Colors.green[900])),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
    }

    widgets.add(PrepaidBillItem(roomSession: roomSessions[i]));
  }
  return widgets;
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Đặt phòng'),
    Tab(text: 'Trả phòng'),
  ];

  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        // The Builder widget is used to have a different BuildContext to access
        // closest DefaultTabController.
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              // Your code goes here.
              // To get index of current tab use tabController.index
            }
          });
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'NT118.L21',
                style: TextStyle(color: kTextColor),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: kTextColor,
                    ),
                    onPressed: () async {
                      try {
                        await AuthFirebase.instance.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  ),
                )
              ],
              backgroundColor: kBackgroundColor,
              shadowColor: Colors.transparent,
              bottom: TabBar(
                controller: _tabController,
                tabs: myTabs,
                labelColor: Constants.kTextColor,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: kTextColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StatsScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.stacked_bar_chart,
                size: 35,
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                BlocBuilder<RoomSessionCubit, RoomSessionState>(
                  builder: (BuildContext context, state) {
                    if (state is RoomSessionLoaded) {
                      final listSession = state.roomSessions;
                      return Container(
                        child: listSession.length != 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ListView(
                                    children: buildPrepaidBills(listSession)),
                              )
                            : Center(
                                child: Text("Chưa có hóa đơn nào"),
                              ),
                      );
                    } else {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                Container(
                  child: widget.listRoomSessionBills.length != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                              children:
                                  buildServices(widget.listRoomSessionBills)),
                        )
                      : Center(
                          child: Text("Chưa có hóa đơn nào"),
                        ),
                ),
              ],
            ),
          );
        }));
  }
}

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({
    Key key,
    this.roomSession,
  }) : super(key: key);

  final RoomSessionBill roomSession;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiptDetail(
              roomSessionBill: roomSession,
            ),
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            roomSession.roomSession.roomUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${roomSession.roomSession.roomName}',
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Constants.kTextColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(roomSession.roomSession.visitorName),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.green[50],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green[900],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat("hh:mm a").format(roomSession.time)}',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  '${NumberFormat().format(roomSession.total)} VNĐ',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrepaidBillItem extends StatelessWidget {
  const PrepaidBillItem({
    Key key,
    this.roomSession,
  }) : super(key: key);

  final RoomSession roomSession;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: ListTile(
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ReceiptDetail(
        //       roomSessionBill: roomSession,
        //     ),
        //   ),
        // ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            roomSession.roomUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${roomSession.roomName}',
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Constants.kTextColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roomSession.visitorName,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.green[50],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'ĐẶT CỌC',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green[900],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat("hh:mm a").format(roomSession.start)}',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  '${NumberFormat().format(roomSession.prepaid)} VNĐ',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
