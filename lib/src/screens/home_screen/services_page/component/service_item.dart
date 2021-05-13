import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'counter.dart';

class ServiceItem extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String urlImage;
  final Function callback;

  const ServiceItem({
    Key key,
    this.name,
    this.description,
    this.price,
    this.urlImage,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0125),
      height: MediaQuery.of(context).size.height * 0.21,
      child: Stack(
        children: [
          Padding(
            // padding: EdgeInsets.only(
            //     left: MediaQuery.of(context).size.height * 0.055),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.035),
            child: Card(
              elevation: 0.2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(
                          left: 110,
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              color: Color.fromARGB(255, 140, 140, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(15),
                            //   color: Colors.blue[100],
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(price,
                                  style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          // Text(
                          //   price,
                          //   style: TextStyle(
                          //     color: Colors.blue[400],
                          //   ),
                          // ),
                          Counter(callback),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            alignment: Alignment.topLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                urlImage,
                width: MediaQuery.of(context).size.height * 0.12,
                height: MediaQuery.of(context).size.height * 0.12,
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
