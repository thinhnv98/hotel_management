import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final int count;
  const CartIcon({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 50,
      child: Stack(
        children: [
          Container(
            width: 50,
            child: Image(
              image: AssetImage("assets/cart_icon.png"),
            ),
          ),
          count > 0
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple[300],
                        border:
                            Border.all(color: Colors.purple[400], width: 0.5)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          count.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
