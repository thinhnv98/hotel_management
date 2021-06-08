import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/room/room_cubit.dart';
import 'package:hotel_management/src/cubit/room_bill/room_bill_cubit.dart';
import 'package:hotel_management/src/cubit/room_session/cubit/room_session_cubit.dart';
import 'package:hotel_management/src/cubit/service/service_cubit.dart';
import 'package:hotel_management/src/data/responsitory/room_bill_repository.dart';
import 'package:hotel_management/src/data/responsitory/room_respository.dart';
import 'package:hotel_management/src/data/responsitory/room_session_repository.dart';
import 'package:hotel_management/src/data/responsitory/service_repository.dart';
import 'package:hotel_management/src/screens/booking_screen/booking_screen.dart';
import 'package:hotel_management/src/screens/home_screen/home_screen.dart';
import 'package:hotel_management/src/screens/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//Stream<QuerySnapshot> fetchProducts() {
//  // ignore: deprecated_member_use
//  return Firestore.instance.collection('product').snapshots(); }

class MyApp extends StatelessWidget {
  final List<BlocProvider> _children = [
    BlocProvider<RoomCubit>(
      create: (context) => RoomCubit(RoomRepository())..loadRooms(),
    ),
    BlocProvider<ServiceCubit>(
      create: (context) => ServiceCubit(ServiceRepository())..getListService(),
    ),
    BlocProvider<RoomBillCubit>(
      create: (context) =>
          RoomBillCubit(RoomSessionBillRepository())..loadRoomSessionBills(),
    ),
    BlocProvider<RoomSessionCubit>(
      create: (context) =>
          RoomSessionCubit(RoomSessionRepository())..loadRoomSessions(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _children,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          BookingScreen.id: (context) => BookingScreen(),
        },
      ),
    );
  }
}
