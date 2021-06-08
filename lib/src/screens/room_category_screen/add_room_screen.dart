import 'package:flutter/material.dart';
import 'package:hotel_management/src/screens/room_category_screen/widgets/a_e_d_screen.dart';
class add_Room_screen extends StatelessWidget {
//  final FocusNode _titleFocusNode = FocusNode();
//  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        _titleFocusNode.unfocus();
//        _descriptionFocusNode.unfocus();
      },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
//          title: AppBarTitle(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddItemForm(
//              titleFocusNode: _titleFocusNode,
//              descriptionFocusNode: _descriptionFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}