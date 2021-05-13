import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/auth_firebase.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/components/hotel_sm_card.dart';
import 'package:hotel_management/src/cubit/room/room_cubit.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/screens/login_screen/login_screen.dart';
import 'package:hotel_management/src/screens/room_detail_screen/room_detail_screen.dart';

class AllRoomsBuilder extends StatelessWidget {
  static const String id = "AllRoom";

  @override
  Widget build(BuildContext context) {
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
      ),
      body: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return buildListRoomLoading();
          } else if (state is RoomLoaded) {
            return buildListRoomLoaded(state.listRoom);
          } else if (state is RoomError) {
            return buildListRoomError(state.message);
          }
          return buildListRoomInitial();
        },
      ),
    );
  }
}

Widget buildListRoomInitial() {
  return ListRoomInitial();
}

Widget buildListRoomLoading() {
  return Container(
    child: Column(
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

Widget buildListRoomLoaded(List<Room> listRoom) {
  return Container(
    child: AllRoomsPage(
      listRoom: listRoom,
    ),
  );
}

Widget buildListRoomError(String message) {
  return Container();
}

class ListRoomInitial extends StatefulWidget {
  @override
  _ListRoomInitialState createState() => _ListRoomInitialState();
}

class _ListRoomInitialState extends State<ListRoomInitial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ListRoomInitial"),
    );
  }
}

class AllRoomsPage extends StatefulWidget {
  final List<Room> listRoom;

  const AllRoomsPage({Key key, @required this.listRoom}) : super(key: key);

  @override
  _AllRoomsPageState createState() => _AllRoomsPageState();
}

class _AllRoomsPageState extends State<AllRoomsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chào (\$name)),",
                style: TextStyle(color: Constants.kGrayColor, fontSize: 16)),
            SizedBox(height: 16),
            Text(
              "DANH SÁCH PHÒNG",
              style: TextStyle(
                  color: Constants.kTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listRoom.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: HotelSmCard(
                      onClick: () {
                        // final roomDetailCubit =
                        //     context.bloc<RoomDetailCubit>();
                        // roomDetailCubit.getRoomDetail(widget.listRoom[index]);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RoomDetailScreenBuilder(
                            key: Key(index.toString()),
                            room: widget.listRoom[index],
                          ),
                        ));
                      },
                      imageUrl: widget.listRoom[index].urlImage,
                      title: widget.listRoom[index].name,
                      price: widget.listRoom[index].price,
                      subtitle: widget.listRoom[index].subtitle,
                      isRented: widget.listRoom[index].currentSession != null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
