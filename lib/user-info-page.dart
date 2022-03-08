import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon( // <-- Icon
                          Icons.person,
                          size: 24.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Account',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    )
                ),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon( // <-- Icon
                          Icons.help_outline_outlined,
                          size: 24.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Help',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),

          ),
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon( // <-- Icon
                    Icons.logout,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Log Out',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ],
              )
          ),


        ],
      ),
    );
  }
}
