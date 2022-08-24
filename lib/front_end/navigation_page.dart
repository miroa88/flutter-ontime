//navigation bar

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../back_end/ontime_user.dart';
import 'user_info_page.dart';
import 'todo_page.dart';
import 'dashboard.dart';
import 'search_meetings_page.dart';


class NavigationScreen extends StatefulWidget {
  const  NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    OnTimeUser.initUsers();
  }




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final screens = [
      Dashboard(FirebaseAuth.instance.currentUser!.uid),
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
        selectedItemColor: Colors.white,
        unselectedItemColor:  Colors.white70,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        //iconSize: ,
        //showUnselectedLabels: false,

      ),

    );
  }
}
