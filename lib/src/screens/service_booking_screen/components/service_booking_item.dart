import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/service/service_cubit.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:intl/intl.dart';

class ServiceBookingItem extends StatelessWidget {
  final RoomService roomService;
  final Color color;

  ServiceBookingItem({this.roomService, this.color});

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
            tileColor: color,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(service.urlImage),
            ),
            isThreeLine: true,
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "${NumberFormat().format(service.price)} VNĐ",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text("Số lượng: " + roomService.quantity.toString()),
            trailing: Text(
              "${NumberFormat().format(roomService.price)} VNĐ",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  //decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue[800]),
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
