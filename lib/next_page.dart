//not related to project
import 'package:flutter/material.dart';
import 'package:practice_app/third_page.dart';
import 'dart:math';
import 'third_page.dart';
import 'user_profile.dart';



class MyNextPage extends StatefulWidget {
  MyNextPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyNextPage> createState() => _MyNextPageState();

}

class _MyNextPageState extends State<MyNextPage> {
  int _counter = 0;
  int _counterGo = 0;
  Random random = Random();
  int _randomNumber = 0;
  String flag = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print("increment to " + _counter.toString());
    });
  }
  void _generateRandomNumber() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _randomNumber = random.nextInt(20);
      if( _randomNumber % 2 == 0 && _randomNumber % 3 == 0) {
        flag = "GO";
        _counterGo++;
      }
      else {
        flag = "DON'T GO";
      }
      //print("increment to " + _randomNumber.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Second Page"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Second page: ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(
              'Generating random numbers',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              '$_counter : $_randomNumber',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextButton(
              child: Text("Click"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed:() {
                _generateRandomNumber();
                _incrementCounter();

              },
            ),
            // if(flag == "GO")
            //   Text(
            //     //'$_randomNumber'
            //     flag,
            //     style: const TextStyle(
            //       color: Colors.green,
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),if(flag == "DON'T GO")
            //   Text(
            //     flag,
            //     style: const TextStyle(
            //       color: Colors.red,
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => {
          //_generateRandomNumber(),

          Navigator.push(context,MaterialPageRoute(builder: (context) => MyThirdPage(title: 'Mythird page')),
          ),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward),
      ),


    );
  }
}
