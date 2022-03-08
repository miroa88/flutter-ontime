//dashboard
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/list_adder.dart';
import 'contact_info_detail.dart';
import 'meeting_date.dart';
import 'creatieg_ meetings.dart';
class MyListView extends StatefulWidget {
  MyListView({Key? key}) : super(key: key) ;

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {

  List<Contact> entries = <Contact>[];

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final typeController = TextEditingController();
  final linkController = TextEditingController();

  _MyListViewState() {
    iniList();
  }

  void iniList() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("contacts");
    DatabaseEvent event = await ref.once();

    for (var element in event.snapshot.children) {
      String n = element.child('name').value.toString();
      String p = element.child('phone').value.toString();
      String t = element.child('type').value.toString();
      String l = element.child('link').value.toString();
      entries.add(Contact(n, p, t, l));
    }
    setState(() {});
  }

  void updateList() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("contacts");
    DatabaseEvent event = await ref.once();
    var element = event.snapshot.children.last;
    String n = element.child('name').value.toString();
    String p = element.child('phone').value.toString();
    String t = element.child('type').value.toString();
    String l = element.child('link').value.toString();
    entries.add(Contact(n, p, t, l));
    setState(() {});
    }

  // void addToList( String n, String p, String t, String a  ) {
  //   setState(() {
  //     entries.add(Contact(n, p, t, a));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => ContactInfoDetail(entries[index])));
              },
              title: Container(
                height: 50,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${entries[index].avatar}'),
                      //https://linkgatesconsult.com/wp-content/uploads/2020/06/logo-person-user-person-icon-800x675.jpg
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 1, left: 5),
                          child: Text(
                            '${entries[index].name}',
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only( top: 1 , left: 5),
                          child: Text(
                              '${entries[index].phoneNumber}'
                          ),

                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      // child: Text(
                      //     '${entries[index].type}',
                      // ),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz),
                          color: Colors.black45

                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateMetings()),
          );
          // openDialog();
        },
        child: const Icon(Icons.add,
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.dashboard),
      //       label: 'Dashboard',
      //       //backgroundColor: Colors.red,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //       //backgroundColor: Colors.red,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.date_range),
      //       label: 'To Do',
      //       //backgroundColor: Colors.red,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Me',
      //       //backgroundColor: Colors.pink,
      //     ),
      //
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      //
      // ),
    );
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Your Contact Information"),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            obscureText: false,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Your Name'
            ),
          ),
          TextField(
            controller: phoneController,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Your Phone Number'
            ),
          ),
          TextField(
            controller: typeController,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Type of Number'
            ),
          ),
          TextField(
            controller: linkController,
            autofocus: true,

            decoration: InputDecoration(
                hintText: 'Profile Picture Link'
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              submit();
            },
            child: Text('SUBMIT')
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);


            },
            child: Text('CANCEL')
        )

      ],
    ),
  );



  void submit() {
    if ( nameController.text.isNotEmpty && phoneController.text.isNotEmpty &&
        typeController.text.isNotEmpty && linkController.text.isNotEmpty){
      FirebaseDatabase.instance.ref().child('contacts/').push().set(
          {
            "name" : nameController.text,
            "phone" : phoneController.text,
            "type" : typeController.text,
            "link" : linkController.text,
          }

      ).then((value) {
        Navigator.of(context).pop();
        //addToList(nameController.text, phoneController.text, typeController.text, linkController.text);
        print("seccesfully added");
      }).catchError((error){
        print("Faild to add");
      });
      updateList();
    }
    else {
      print("some fields are empty");
    }
    }

  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Dashboard',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Search',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: To Do',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 3: Me',
  //     style: optionStyle,
  //   ),
  // ];


  // void _onItemTapped(int value) {
  //   setState(() {
  //     _selectedIndex = value;
  //   });
  // }
}
