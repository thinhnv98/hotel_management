import 'package:flutter/material.dart';
import 'package:hotel_management/src/data/model/room_model.dart';
import 'package:hotel_management/src/data/model/room_service_model.dart';
import 'package:hotel_management/src/screens/home_screen/services_page/component/cart_icon.dart';
import 'package:intl/intl.dart';

import 'submit_button.dart';

class OrderBottomSheet extends StatelessWidget {
  final List<RoomService> tempServices;

  const OrderBottomSheet({Key key, this.tempServices}) : super(key: key);

  double totalPrice() {
    double result = 0;
    tempServices.forEach((service) {
      result += service.singularPrice * service.quantity;
    });
    return result;
  }

  int totalOrder() {
    int result = 0;
    tempServices.forEach((service) {
      result += service.quantity;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CartIcon(
                count: totalOrder(),
              ),
              SizedBox(width: 5),
              Text(
                NumberFormat().format(totalPrice()) + " VNĐ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: ServiceSubmitButton(tempServices: tempServices)),
        ],
      ),
    );
  }
}
