import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/front_end/navigation_page.dart';
import 'create_date_time.dart';

class CreateTitle extends StatefulWidget {
  final String userId;
  final String recordId;
  CreateTitle(this.userId, this.recordId);

  @override
  _CreateTitleState createState() => _CreateTitleState();
}

class _CreateTitleState extends State<CreateTitle> {
  bool _granted = true;
  bool _typeChecked = true;
  bool _titleChecked = true;
  var titleController = TextEditingController();

  List<String> options = <String>[
    'Please select','Zoom','Google Meet','Phone call','In person'
  ];
  String dropdownValue = "Please select";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Create New Meeting'),
            Spacer(),
            IconButton(onPressed: (){
              _deleteUser(widget.userId,widget.recordId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                    (Route<dynamic> route) => false,
              );
            }, icon: Icon(Icons.close)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 25, top: 35),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text("Choose a title for your meeting ",
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Enter a title',
                        hintStyle: _titleChecked ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.red)
                    ),
                    autofocus: true
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Select Meeting Type",
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Colors.black
                  ),
                ),
                Spacer(),
                Container(
                    width: 135,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid
                        )
                    ),
                    child: DropdownButton<String>(
                      isDense: true,
                      value: dropdownValue,
                      items: options.map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: value == dropdownValue?
                            Text(
                              value,
                              style: const TextStyle(color: Colors.grey),
                            ) : Text(value)
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        // do something here
                        setState(() {
                          dropdownValue = newValue??dropdownValue;
                          _typeChecked = true;
                        });
                      },
                      underline: DropdownButtonHideUnderline(child: Container()),
                      style: const TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.grey,
                      ),
                      selectedItemBuilder: (BuildContext context){
                        return options.map((String value) {
                          return Text(
                              dropdownValue,
                              style: TextStyle(
                                  color: _typeChecked ? Colors.blue : Colors.red,
                                  fontWeight: FontWeight.bold
                              )
                          );
                        }).toList();
                      },
                    )
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                        onPrimary: Colors.white, // Text Color (Foreground color)
                      ),

                      onPressed: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NextPage()),
                    // );
                    if(dropdownValue == "Please select")
                    {
                      setState(() {
                        _typeChecked = false;
                        _granted = false;
                      });
                    }
                    if(titleController.text == "")
                    {
                      setState(() {
                        _titleChecked = false;
                        _granted = false;
                      });
                    }
                    else
                    {
                      _titleChecked = true;
                    }
                    if( _titleChecked && _typeChecked)
                    {
                      _granted = true;
                    }
                    if(_granted)
                    {
                      final titleList =  searchElementGenerator(titleController.text);
                      final typeList = searchElementGenerator(dropdownValue);
                      _addUser(widget.userId,widget.recordId, titleController.text,dropdownValue);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CreateDateTime(widget.userId,widget.recordId,dropdownValue,titleList + typeList)));
                    }
                  }, child: Text("NEXT")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> _addUser(String userID, String recordID, String title, String type) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");

    return users
        .doc(recordID)
        .update({
      'Title': title,
      'Meeting_type': type,
    })
        .then((value) => print("Title Added"))
        .catchError((error) => print("Failed to add tile: $error"));
  }

  Future<void> _deleteUser(String userID, String recordID) {
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(userID).collection("records");
    return users
        .doc(recordID)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  List<String> searchElementGenerator(String s) {
    List<String> tempList = List<String>.empty(growable: true);
    String sLower = s.toLowerCase();

    for (int i = 0; i < sLower.length; i++) {
      if(i == 0) {
        tempList.add(sLower[i]);
      }
      else {
        tempList.add(tempList[i-1] + sLower[i]);
      }

    }
    return tempList;
  }


}



