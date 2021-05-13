import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/service/service_cubit.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:intl/intl.dart';

class RoomServiceItem extends StatelessWidget {
  final RoomService roomService;

  RoomServiceItem({this.roomService});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        if (state is ServiceLoaded) {
          var service = state.listService.firstWhere(
            (element) => element.id == roomService.serviceId,
            orElse: () => null,
          );
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(service.urlImage),
            ),
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                service.name,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Số lượng: " + roomService.quantity.toString()),
            ),
            trailing: Text(
              "${NumberFormat().format(roomService.price)} VNĐ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        } else
          return Container(
            child: Text("Loading..."),
          );
      },
    );
  }
}
