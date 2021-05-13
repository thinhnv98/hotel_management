import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget title;
  final Widget subtile;
  const InfoCard({
    Key key,
    this.title,
    this.subtile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              title,
              SizedBox(
                height: 10,
              ),
              subtile
            ],
          ),
        ),
      ),
    );
  }
}
