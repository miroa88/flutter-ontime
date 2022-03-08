//coping link pass etc

import 'package:flutter/foundation.dart';
import 'my_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingTypePage extends StatefulWidget {
  const MeetingTypePage({Key? key}) : super(key: key);

  @override
  _MeetingTypePageState createState() => _MeetingTypePageState();
}

class _MeetingTypePageState extends State<MeetingTypePage> {


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Meeting'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left:10, right: 10),
            width: _width,
            height: _height/9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 82,
                      child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Meeting Link'
                          ),
                          autofocus: true
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 18,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () {},
                        child: const Text('PASTE'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text("Enter meeting link",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Meeting Password'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {},
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter meeting password",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Phone Meeting Number'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {},
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter Phone number",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left:10, right: 10, bottom: 5),
              width: _width,
              height: _height/9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 82,
                        child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Meeting Address'
                            ),
                            autofocus: true
                        ),
                      ),
                      //Spacer(),
                      Expanded(
                        flex: 18,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {},
                          child: const Text('PASTE'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("Enter Meeting Address",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: ElevatedButton(

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyNavigation()),
                    );

                  },
                  child: const Text('CREATE'),
                ),
              ),
            ],

          )
        ],
      ),


    );
  }
}


