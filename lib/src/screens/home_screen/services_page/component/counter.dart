import 'package:flutter/material.dart';
import 'package:hotel_management/src/components/circle_button.dart';
import 'package:hotel_management/src/data/model/service_model.dart';
import 'package:intl/intl.dart';

class Counter extends StatefulWidget {
  final Function(int) callback;

  Counter(this.callback);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count;
  @override
  void initState() {
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          CircleButton(
            color: count > 0 ? Color.fromARGB(255, 100, 100, 255) : Colors.grey,
            iconData: Icons.remove,
            size: 22,
            onPress: () {
              setState(() {
                if (count <= 0) return;
                count--;
                widget.callback(count);
              });
            },
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          CircleButton(
            color: Color.fromARGB(255, 100, 100, 255),
            iconData: Icons.add,
            size: 22,
            onPress: () {
              setState(() {
                count++;
                widget.callback(count);
              });
            },
          ),
        ],
      ),
    );
  }
}
