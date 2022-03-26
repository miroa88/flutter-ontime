//to do
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }
  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'CS2500',
      'CS2144',
      'CS2500',
      'CS2144',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),

      body: Column(
        children: [
          Expanded(
            flex: 25,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CalendarTimeline(
                      showYears: false,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 1000)),
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date!;
                          print(_selectedDate);
                        });
                      },
                      leftMargin: 20,
                      monthColor: Colors.black87,
                      dayColor: Colors.black,
                      dayNameColor: Colors.blue,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: Colors.blue,
                      dotsColor: Colors.white,
                      selectableDayPredicate: (date) => date.day != 23,
                      locale: 'en_ISO',
                    ),
                    // SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16),
                    //   child: TextButton(
                    //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[200])),
                    //     child: Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                    //     onPressed: () => setState(() => _resetSelectedDate()),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Center(child: Text('Selected date is $_selectedDate', style: TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 75,
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(items[index]),
                              CircleAvatar(
                                backgroundImage: NetworkImage("https://companiesmarketcap.com/img/company-logos/512/ZM.png"),
                                //https://linkgatesconsult.com/wp-content/uploads/2020/06/logo-person-user-person-icon-800x675.jpg
                              ),
                            ],
                          ),
                        ],
                      )),
                  //dense: true,
                  // isThreeLine: true,
                ),
              );
            },
          ),
              
              // ListView(
              //   children: const <Widget>[
              //     Card(child: ListTile(title: Text('One-line ListTile'))),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(),
              //         title: Text('One-line with leading widget'),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         title: Text('One-line with trailing widget'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(),
              //         title: Text('One-line with both widgets'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         title: Text('One-line dense ListTile'),
              //         dense: true,
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(size: 56.0),
              //         title: Text('Two-line ListTile'),
              //         subtitle: Text('Here is a second line'),
              //         trailing: Icon(Icons.more_vert),
              //       ),
              //     ),
              //     Card(
              //       child: ListTile(
              //         leading: FlutterLogo(size: 72.0),
              //         title: Text('Three-line ListTile'),
              //         subtitle: Text(
              //             'A sufficiently long subtitle warrants three lines.'
              //         ),
              //         trailing: Icon(Icons.more_vert),
              //         isThreeLine: true,
              //       ),
              //     ),
              //   ],
              // )

          )
        ],
      ),
    );
  }
}
