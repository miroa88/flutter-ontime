//ts not related to project

import 'package:flutter/material.dart';
import 'package:practice_app/list_view.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('User Prifile'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 20,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.lightBlueAccent,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: Container(
                    child: Image(
                        image: NetworkImage('https://www.citypng.com/public/uploads/preview/genshin-impact-game-blue-logo-png-img-31633003587br1aaravbc.png')
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: IconButton(
                    icon: const Icon(Icons.chat),
                    color: Colors.lightBlueAccent,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 65,
            child: Column(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("https://media.npr.org/assets/img/2014/08/07/monkey-selfie_custom-7117031c832fc3607ee5b26b9d5b03d10a1deaca-s300-c85.webp"),
                      ),
                    ),
                  ),

                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20 ),
                    child: Row(

                        children: [
                          Text("Miro, 33"),
                          Spacer(),
                          Row(
                            children: [
                              Text("8"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.camera_alt_rounded),
                            ],
                          )
                        ],
                      ),
                  ),
                  ),
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex:45,
                          child: Row(
                            children: [
                              Text("8"),
                              Spacer(),
                              Icon(Icons.camera_alt_rounded),

                            ],

                          ),
                        ),
                        Expanded(
                            flex: 10,
                            child: SizedBox(
                          // width: 5,
                        ),
                        ),
                        Expanded(
                          flex: 45,
                          child: Row(
                            children: [
                              Text("8"),
                              Spacer(),
                              Icon(Icons.camera_alt_rounded),
                            ],

                          ),
                        ),
                      ],

                    ),
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (){},
                    icon: Image.network('https://cdn.icon-icons.com/icons2/2596/PNG/512/check_one_icon_155665.png'),
                    iconSize: 40,
                ),
                IconButton(
                  onPressed: (){
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => MyListView()));
                  },
                  icon: Image.asset('images/cross.jpg'),
                  iconSize: 40,
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
