import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management/src/cubit/room/room_cubit.dart';
import 'package:hotel_management/src/screens/room_category_screen/room_screen_build.dart';
import 'package:hotel_management/src/screens/room_category_screen/widgets/a_e_d_screen.dart';
import 'package:hotel_management/src/screens/room_category_screen/widgets/rooms_card_screen.dart';

class RoomCategoricalScreen extends StatelessWidget {
  static const String id = "ROOM_DETAIL";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
        backgroundColor: kBackgroundColor,
        shadowColor: Colors.transparent,
      ),
      body: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return _buildListRoomLoading();
          } else if (state is RoomLoaded) {
            return _buildListRoomLoaded(state.listRoom);
          } else if (state is RoomError) {
            return _buildListRoomError(state.message);
          }
          return _buildListRoomInitial();
        },
      ),
    );
  }
}

Widget _buildListRoomInitial() {
  return _ListRoomInitial();
}

Widget _buildListRoomLoading() {
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

Widget _buildListRoomLoaded(List<Room> listRoom) {
  return Container(
    child: RoomsPage(
      listRoom: listRoom,
    ),
  );
}

Widget _buildListRoomError(String message) {
  return Container();
}

class _ListRoomInitial extends StatefulWidget {
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<_ListRoomInitial> {
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

class RoomsPage extends StatefulWidget {
  final List<Room> listRoom;

  const RoomsPage({Key key, @required this.listRoom}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Padding(

          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DANH SÁCH PHÒNG",
                style: TextStyle(
                    color: Constants.kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children:[
//                  Column(
//                    children: [
//                      IconButton(
//                        icon: Icon(Icons.import_contacts_sharp),
//                        onPressed: () =>{AddItemForm()},
//                      )
//                    ],
//                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.add_circle_outline),
                    label: Text("Add Room"),
                    onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddItemForm(
//                    key: Key(index.toString()),
//                    room: widget.listRoom[index],
                    ),
                    )
                    )
                    },

                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                  ),
                  SizedBox(height: 10),
              ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.listRoom.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RoomsCardScreen(
                        onClick: () {
                          // final roomDetailCubit =
                          //     context.bloc<RoomDetailCubit>();
                          // roomDetailCubit.getRoomDetail(widget.listRoom[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RoomScreenBuilder(
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
      ),
    );
  }
}
