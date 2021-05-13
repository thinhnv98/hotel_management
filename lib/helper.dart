import 'package:flutter/material.dart';

final Color kTextColor = Color(0xFF1B1D68);
final Color kGrayColor = Color(0xFFA5A6C4);
final Color kBackgroundColor = Color(0xFFF8F8F8);
final String phoneServiceId = "ZzEQNeNUOua8xCcmNYZQ";
final String foodServiceId = "jHeQLouOKTVVsuh5WfxF";
final String laundryServiceId = "lSneLjnXBfqWcnnJkbhY";

class Constants {
  static final Color kTextColor = Color(0xFF1B1D68);
  static final Color kGrayColor = Color(0xFFA5A6C4);
  static final Color kBackgroundColor = Color(0xFFF8F8F8);
}

class Helper {
  Helper._privateConstructor();

  static final Helper _instance = Helper._privateConstructor();

  static Helper get instance => _instance;

  final mailValidator = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool isEmailValid(String email) => mailValidator.hasMatch(email);
}
