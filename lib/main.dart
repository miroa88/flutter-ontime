// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'next_page.dart';
import 'my_navigation_page.dart';
import 'from_scratch.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // primarySwatch: Colors.blue
        //  primarySwatch: Palette.kToDark,

      ),
      home:  FromScratchPage(),//const MyHomePage(title: 'Flutter Demo Home Page'),
      //
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
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
      //print("increment to " + _counter.toString());
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

        title: Text(widget.title),
      ),
      body:Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              width: 400,
              margin: EdgeInsets.all(30),
              child: const Image(
                image: NetworkImage('https://www.reviewjournal.com/wp-content/uploads/2019/05/12232763_web1_SLOT-TECH_051519cs_003.jpg?crop=1'),
              ),
            ),
            Container(
margin: EdgeInsets.all(20),
child: const Text(
'Should I go casino?',
style: TextStyle(
fontSize: 24,
),
),
),
Text(
'$_counter : $_counterGo',
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.w300,
),
),
if(flag == "GO")
Text(
//'$_randomNumber'
flag,
style: const TextStyle(
color: Colors.green,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
if(flag == "DON'T GO")
Text(
flag,
style: const TextStyle(
color: Colors.red,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

Container(
margin: EdgeInsets.all(20),
child: TextButton(
child: const Text("Click"),
style: TextButton.styleFrom(
primary: Colors.white,
backgroundColor: Colors.blue,
),
onPressed:() {
_generateRandomNumber();
_incrementCounter();

},
),
),
],
),
),
      floatingActionButton: FloatingActionButton(
        onPressed:() => {
          //_generateRandomNumber(),

          Navigator.push(context,MaterialPageRoute(builder: (context) => MyNextPage()),
          ),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward),
      ),

    );
  }
}




// onPressed:() => {
//
// Navigator.push(context,MaterialPageRoute(builder: (context) => MyNextPage()),
// ),
// },




// Center(
//
// child: Column(
//
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Container(
// width: 400,
// margin: EdgeInsets.all(30),
// child: const Image(
// image: NetworkImage('https://www.reviewjournal.com/wp-content/uploads/2019/05/12232763_web1_SLOT-TECH_051519cs_003.jpg?crop=1'),
// ),
// ),
// Container(
// margin: EdgeInsets.all(20),
// child: const Text(
// 'Should I go casino?',
// style: TextStyle(
// fontSize: 24,
// ),
// ),
// ),
// Text(
// '$_counter : $_counterGo',
// style: const TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.w300,
// ),
// ),
// if(flag == "GO")
// Text(
// //'$_randomNumber'
// flag,
// style: const TextStyle(
// color: Colors.green,
// fontSize: 24,
// fontWeight: FontWeight.bold,
// ),
// ),
// if(flag == "DON'T GO")
// Text(
// flag,
// style: const TextStyle(
// color: Colors.red,
// fontSize: 24,
// fontWeight: FontWeight.bold,
// ),
// ),
//
// Container(
// margin: EdgeInsets.all(20),
// child: TextButton(
// child: const Text("Click"),
// style: TextButton.styleFrom(
// primary: Colors.white,
// backgroundColor: Colors.blue,
// ),
// onPressed:() {
// _generateRandomNumber();
// _incrementCounter();
//
// },
// ),
// ),
// ],
// ),
// ),