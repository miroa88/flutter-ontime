//its a practice page; its not related to project
import 'package:flutter/material.dart';

class Deadline extends StatelessWidget {
  const Deadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dead line page"),
      ),
      body: ListView(
        children: [
          Text("full text"),
          SizedBox(
            height: 8,
          ),
          Expanded(child: Image.asset('images/frame.png')),
          ElevatedButton.icon(onPressed: (){
            Navigator.pop(context);
            },
            icon: Icon(Icons.assignment_return),
            label: Text("Back"),
          ),
        ],
      ),
    );
  }
}
