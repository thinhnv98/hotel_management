import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData iconData;
  final Function onPress;
  const CircleButton(
      {Key key, this.size, this.color, this.iconData, this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      color: color,
      textColor: Colors.white,
      child: Icon(
        iconData,
        size: size,
      ),
      height: size,
      minWidth: size,
      shape: CircleBorder(),
    );
  }
}
