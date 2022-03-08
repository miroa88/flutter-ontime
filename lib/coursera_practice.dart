//good example to starts a main from scratch
import 'package:flutter/material.dart';
import 'deadline.dart';
void main(){
  runApp(
      MaterialApp(
        home: MainCoursera(),
      )
  );
}

class MainCoursera extends StatelessWidget {
  const MainCoursera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.home)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.person_add_alt)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.video_call)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.verified_user)
              ),
            ],
          ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              height: 300,
              child: Column(
                children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('images/photo.jpg'),
                      ),
                      onTap: (){print("list tile pressed");},
                      title: Text("Miro Abdalian"),
                      subtitle: Text("march 31 2021"),
                      trailing: Icon(Icons.more_horiz),
                    ),
                  Align(
                  alignment: Alignment.centerLeft,
                      child: Text("Hello every body. I am here.")
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: Image.asset('images/photo.jpg')
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Row(
                          children: [
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.thumb_up)
                            ),
                            Text("Like"),
                          ],
                        ),

                      Row(
                          children: [
                            IconButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder:  (context) => Deadline()));
                                },
                                icon: Icon(Icons.read_more)
                            ),
                            Text("Read More"),
                          ],
                        ),

                     Row(
                          children: [
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.share)
                            ),
                            Text("share"),
                          ],
                        ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Hi");
        },
        child: Icon(Icons.menu),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}

