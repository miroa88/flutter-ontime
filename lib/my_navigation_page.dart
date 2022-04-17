//navigation bar

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:practice_app/main.dart';
import 'list_view.dart';
import 'to_do_page.dart';
import 'search_meeting-page.dart';
import 'user-info-page.dart';

class MyNavigation extends StatefulWidget {
  final String documentId;
  MyNavigation(this.documentId);
  // MyNavigation({Key? key, required this.documentId}) : super(key: key);

  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("hello");
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    final screens = [
      MyListView(widget.documentId),
      SearchMeeting(),
      ToDoPage(),
      UserInfoPage(),
    ];
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'To Do',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
            backgroundColor: Colors.blue,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        //iconSize: ,
        //showUnselectedLabels: false,


      ),

    );
  }
}
