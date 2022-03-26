import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'meeting_date.dart';
import 'my_navigation_page.dart';
class CreateMetings extends StatefulWidget {
  // const CreateMetings({Key? key}) : super(key: key);
  final String userId;
  final String recordId;
  CreateMetings(this.userId, this.recordId);

  @override
  _CreateMetingsState createState() => _CreateMetingsState();
}

class _CreateMetingsState extends State<CreateMetings> {

  var titleController = TextEditingController();

  String selectedValue = "Please select";
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Please select"),value: "Please select"),
      DropdownMenuItem(child: Text("Zoom"),value: "Zoom"),
      DropdownMenuItem(child: Text("Google Meet"),value: "Google Meet"),
      DropdownMenuItem(child: Text("Phone"),value: "Phone"),
      DropdownMenuItem(child: Text("In Person"),value: "In Person"),
    ];
    return menuItems;
  }

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
                MaterialPageRoute(builder: (context) => MyNavigation(widget.userId)),
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
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Meeting Title'
                  ),
                    autofocus: true


                ),
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
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
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
                      fontStyle: FontStyle.italic,
                      color: Colors.black
                  ),
                ),
                Spacer(),

                DropdownButton(
                  value: selectedValue,

                  onChanged: (String? newValue){
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: (){
                  _addUser(widget.userId,widget.recordId, titleController.text,selectedValue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeetingDatePage(widget.userId,widget.recordId)),
                  );
                }, child: Text("NEXT"))
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

}
