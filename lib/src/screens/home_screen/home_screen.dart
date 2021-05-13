import 'package:flutter/material.dart';
import 'package:hotel_management/helper.dart';
import 'package:hotel_management/src/screens/home_screen/all_rooms_page.dart';
import 'package:hotel_management/src/screens/receipt_screen/reciept_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HOME";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: kTextColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Trang chủ",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Hóa đơn",
            icon: Icon(Icons.receipt),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: PageView(
        controller: _pageController,
        children: [
          AllRoomsBuilder(),
          ReceiptScreenBuilder(),
        ],
        onPageChanged: (index) => _onPageChanged(index),
      ),
    );
  }
}
