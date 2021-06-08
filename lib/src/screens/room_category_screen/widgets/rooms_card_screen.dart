import 'package:flutter/material.dart';
import 'package:hotel_management/helper.dart';
import 'package:intl/intl.dart';

class RoomsCardScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final int price;
  final VoidCallback onClick;
  final bool isRented;

  RoomsCardScreen({
    @required this.imageUrl,
    @required this.title,
    @required this.subtitle,
    @required this.price,
    @required this.onClick,
    @required this.isRented,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        elevation: 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Hero(
                    tag: imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Constants.kTextColor),
                          ),
                          (!isRented)
                              ? Container(
                                 decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                                   color: Colors.green[50],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                                 child: Text(
                              'TRỐNG',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green[900],
                              ),
                            ),
                          )
                              : isRented
                              ? Icon(
                            Icons.brightness_1,
                            color: Colors.red,
                            size: 16,
                          )

                              : Container(),

                        ]),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 12),
                    Text(
                      "${NumberFormat().format(price)} VNĐ/ ngày",
                      style: TextStyle(
                          color: Constants.kTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
///////////////////////////// Done
//              Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: [
//                  IconButton(
//                    icon: Icon(Icons.edit,size: 25,),
//                    color: Colors.indigo,
//                    onPressed: (){},
////                                  onPressed: () =>
////                                      _createOrUpdate(documentSnapshot)
//                  ),
//                  // This icon button is used to delete a single product
//                  IconButton(
//                    icon: Icon(Icons.delete,size: 25),
//                    color: Colors.indigo,
//                    onPressed: (){},
////                                  onPressed: () =>
////                                      _deleteProduct(documentSnapshot.id)
//                  ),
//                ],
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
