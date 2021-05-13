import 'package:flutter/material.dart';
import 'package:hotel_management/src/screens/stats_screen/models/service_stats_model.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class DetailChart extends StatefulWidget {
  final List<ServiceStatsModel> listServiceStatsModel;

  const DetailChart({Key key, this.listServiceStatsModel}) : super(key: key);
  @override
  _DetailChartState createState() => _DetailChartState();
}

class _DetailChartState extends State<DetailChart> {
  List<charts.Series<Properties, String>> dataList = [];

  @override
  void initState() {
    super.initState();
  }

  bool isRoomPrice = true;
  bool isPhonePrice = true;
  bool isFoodPrice = true;
  bool isLaundryPrice = true;

  int key = 0;

  initData() {
    dataList = [];
    int i = 0;
    widget.listServiceStatsModel.sort(
      (a, b) => a.checkoutDate.compareTo(b.checkoutDate),
    );
    Map<String, Properties> servicesStats = {};
    widget.listServiceStatsModel.forEach((serviceStatsModel) {
      if (serviceStatsModel.roomPrice > 0 && isRoomPrice) {
        servicesStats.addAll({
          "${(i++).toString()}": Properties(
              DateFormat("dd-MM-yyyy").format(serviceStatsModel.checkoutDate),
              serviceStatsModel.roomPrice,
              Colors.green)
        });
      }
      if (serviceStatsModel.foodPrice > 0 && isFoodPrice) {
        servicesStats.addAll({
          "${(i++).toString()}": Properties(
              DateFormat("dd-MM-yyyy").format(serviceStatsModel.checkoutDate),
              serviceStatsModel.foodPrice,
              Colors.red)
        });
      }
      if (serviceStatsModel.phonePrice > 0 && isPhonePrice) {
        servicesStats.addAll({
          "${(i++).toString()}": Properties(
              DateFormat("dd-MM-yyyy").format(serviceStatsModel.checkoutDate),
              serviceStatsModel.phonePrice,
              Colors.blue)
        });
      }
      if (serviceStatsModel.laundryPrice > 0 && isLaundryPrice) {
        servicesStats.addAll({
          "${(i++).toString()}": Properties(
              DateFormat("dd-MM-yyyy").format(serviceStatsModel.checkoutDate),
              serviceStatsModel.laundryPrice,
              Colors.yellow)
        });
      }
    });
    servicesStats.forEach(
      (key, value) {
        dataList.add(
          charts.Series<Properties, String>(
            id: key,
            domainFn: (Properties value, _) => "${value.day}",
            measureFn: (Properties value, _) => value.price,
            seriesCategory: key,
            strokeWidthPxFn: (_, __) => 0,
            displayName: "",
            fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(value.color),
            data: [value],
            labelAccessorFn: (Properties value, _) =>
                "${NumberFormat().format(value.price)} VNĐ",
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listServiceStatsModel.length == 0) {
      return Center(
        child: Text("No Room Session Bill"),
      );
    }
    var size = MediaQuery.of(context).size;
    final currencyFormatter =
        charts.BasicNumericTickFormatterSpec.fromNumberFormat(
      NumberFormat.simpleCurrency(locale: "vi", decimalDigits: 0),
    );
    initData();
    return Column(
      children: [
        Container(
          width: 270,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tiền phòng:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      activeColor: Colors.green,
                      value: isRoomPrice,
                      onChanged: (value) {
                        setState(() {
                          isRoomPrice = value;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dịch vụ điện thoại:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      activeColor: Colors.blue,
                      value: isPhonePrice,
                      onChanged: (value) {
                        setState(() {
                          isPhonePrice = value;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dịch vụ ăn uống:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      activeColor: Colors.red,
                      value: isFoodPrice,
                      onChanged: (value) {
                        setState(() {
                          isFoodPrice = value;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dịch vụ giặt ủi:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Checkbox(
                      activeColor: Colors.yellow,
                      value: isLaundryPrice,
                      onChanged: (value) {
                        setState(() {
                          isLaundryPrice = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          height: size.width * 0.95,
          width: size.width,
          child: charts.BarChart(
            dataList,
            animate: true,
            barRendererDecorator: new charts.BarLabelDecorator(
              labelAnchor: charts.BarLabelAnchor.start,
              labelPosition: charts.BarLabelPosition.outside,
              labelPadding: 10,
              insideLabelStyleSpec: new charts.TextStyleSpec(
                fontSize: 12,
                color: charts.MaterialPalette.black.darker,
              ),
              outsideLabelStyleSpec: new charts.TextStyleSpec(
                fontSize: 12,
                color: charts.MaterialPalette.black.darker,
              ),
            ),
            barGroupingType: charts.BarGroupingType.stacked,
            primaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec:
                  new charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
              showAxisLine: true,
              tickFormatterSpec: currencyFormatter,
              renderSpec: new charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.MaterialPalette.black.lighter,
                ),
              ),
            ),
            domainAxis: new charts.OrdinalAxisSpec(
              showAxisLine: true,
              renderSpec: new charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.MaterialPalette.black.lighter,
                ),
              ),
            ),
            defaultInteractions: false,
          ),
        ),
      ],
    );
  }
}

class Properties {
  final String day;
  final double price;
  final Color color;

  Properties(this.day, this.price, this.color);
}
