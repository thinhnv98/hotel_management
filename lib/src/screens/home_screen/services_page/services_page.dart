import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management/src/cubit/service/service_cubit.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/data/model/service_model.dart';
import 'package:hotel_management/src/screens/home_screen/services_page/component/order_bottom_sheet.dart';
import 'package:intl/intl.dart';

import 'component/service_item.dart';

class ServicePageBuilder extends StatelessWidget {
  const ServicePageBuilder({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        if (state is ServiceInitial) {
          return buildListServiceInitial();
        } else if (state is ServiceLoading) {
          return buildListServiceLoading();
        } else if (state is ServiceLoaded) {
          return buildListServiceLoaded(listService: state.listService);
        } else if (state is ServiceError) {
          return buildListServiceError(state.message);
        } else {
          return Container();
        }
      },
    );
  }
}

Widget buildListServiceInitial() {
  return ListServiceInitial();
}

Widget buildListServiceLoading() {
  return WillPopScope(
    onWillPop: () async => false,
    child: SimpleDialog(
      backgroundColor: Colors.black54,
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(
                "Đang tải dịch vụ...",
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildListServiceLoaded({List<Service> listService}) {
  return Container(
    child: ServicePage(
      listService: listService,
    ),
  );
}

Widget buildListServiceError(String message) {
  return Container();
}

class ListServiceInitial extends StatefulWidget {
  @override
  _ListServiceInitialState createState() => _ListServiceInitialState();
}

class _ListServiceInitialState extends State<ListServiceInitial> {
  @override
  void initState() {
    super.initState();
    final serviceCubit = context.bloc<ServiceCubit>();
    serviceCubit.getListService();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ServicePage extends StatefulWidget {
  final List<Service> listService;

  const ServicePage({Key key, this.listService}) : super(key: key);
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<RoomService> tempServices = List<RoomService>();

  setServiceQuantity(Service service, int quantity) {
    for (int i = 0; i < tempServices.length; ++i) {
      if (tempServices[i].serviceId == service.id) {
        tempServices[i].quantity = quantity;
        if (tempServices[i].quantity <= 0) tempServices.removeAt(i);
        return;
      }
    }

    if (quantity > 0)
      tempServices.add(
        new RoomService(
          serviceId: service.id,
          quantity: quantity,
          singularPrice: service.price,
          date: DateTime.now(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: tempServices.length > 0
            ? OrderBottomSheet(tempServices: tempServices)
            : Container(
                height: 0,
              ),
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
            "Dịch vụ",
            style: TextStyle(
              color: Colors.black,
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
          //color: Color(0xFFF8F9FA),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[50],
                Colors.grey[100],
                Colors.grey[200],
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: List<Widget>.generate(
              widget.listService.length,
              (index) => ServiceItem(
                key: Key(index.toString()),
                name: widget.listService[index].name,
                description: widget.listService[index].description,
                price:
                    "${NumberFormat().format(widget.listService[index].price)} VNĐ / ${widget.listService[index].unit}",
                urlImage: widget.listService[index].urlImage,
                callback: (int quantity) {
                  setServiceQuantity(widget.listService[index], quantity);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
