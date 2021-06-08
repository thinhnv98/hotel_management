import 'package:flutter/material.dart';
import 'package:hotel_management/src/screens/stats_screen/models/service_stats_model.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

enum LegendShape { Circle, Rectangle }

class CompareChart extends StatefulWidget {
  final List<ServiceStatsModel> listServiceStatsModel;

  CompareChart(this.listServiceStatsModel);
  @override
  _CompareChartState createState() => _CompareChartState();
}

class _CompareChartState extends State<CompareChart> {
  double totalRoomPrice = 0;
  double totalFoodPrice = 0;
  double totalPhonePrice = 0;
  double totalLaudryPrice = 0;
  Map<String, double> dataMap;

  List<Color> colorList = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
  ];

  int key = 0;

  initData() {
    totalRoomPrice = 0;
    totalFoodPrice = 0;
    totalPhonePrice = 0;
    totalLaudryPrice = 0;
    widget.listServiceStatsModel.forEach((element) {
      totalRoomPrice += element.roomPrice;
      totalFoodPrice += element.foodPrice;
      totalPhonePrice += element.phonePrice;
      totalLaudryPrice += element.laundryPrice;
    });
    dataMap = {
      "Tiền phòng": totalRoomPrice,
      "Dịch vụ điện thoại": totalPhonePrice,
      "Dịch vụ ăn uống": totalFoodPrice,
      "Dịch vụ giặt ủi": totalLaudryPrice,
    };
  }

  @override
  Widget build(BuildContext context) {
    initData();
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(seconds: 2),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      //centerText: _showCenterText ? "HYBRID" : null,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        decimalPlaces: 0,
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: true,
      ),
      formatChartValues: (value) => "${NumberFormat().format(value)} VNĐ",
    );

    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        child: chart,
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
      );
    });
  }
}