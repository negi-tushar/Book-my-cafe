import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restroapp/provider/userProvider.dart';
import 'package:restroapp/screens/booking_screen.dart';
import 'package:restroapp/screens/google_map_screen.dart';
import 'package:restroapp/screens/homescreen.dart';
import 'package:restroapp/screens/profile_screen.dart';
import 'package:restroapp/services/getCurrentLocation.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);
  static const String id = '/MyBottomNavigationBar';

  @override
  State<MyBottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _index = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];
  void updatePage(int page) {
    setState(() {
      _index = page;
    });
  }

  @override
  void initState() {
    CurrentLocation().getCurrentLocation(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).refreshUsers();
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: updatePage,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: _index == 0 ? Colors.brown : Colors.white,
                  ),
                ),
              ),
              child: _index == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: _index == 1 ? Colors.brown : Colors.white,
                  ),
                ),
              ),
              child: _index == 1
                  ? const Icon(Icons.food_bank)
                  : const Icon(Icons.food_bank_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: _index == 2 ? Colors.brown : Colors.white,
                  ),
                ),
              ),
              child: _index == 2
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
