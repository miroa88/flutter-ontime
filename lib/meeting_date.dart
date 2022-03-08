//picking date
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'meeting_type_page.dart';
class MeetingDatePage extends StatefulWidget {
  const MeetingDatePage({Key? key}) : super(key: key);

  @override
  _MeetingDatePageState createState() => _MeetingDatePageState();

}

class _MeetingDatePageState extends State<MeetingDatePage> {
  late DateTime _dateTime;
  bool isChecked = false;
  bool pressAttention = false;

  TimeOfDay _time = TimeOfDay.now();
  Future<Null> selectTime(BuildContext context) async{
    _time = (await showTimePicker(context: context
        , initialTime: _time
    ))!;
  }


  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }






  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    var _dateController;

    var checkedValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Meeting'),
      ),
      body:ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Meeting Date',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                ),

                ),
              trailing: Icon(Icons.date_range,
                color: Colors.blue,),
              subtitle: Text('Choose a date for your meeting'),
              // selected: true,
              onTap: () {
                _selectDate(context);

              },
              //leading: Icon(Icons.add),

            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('Meeting Start Time',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                ),),
              trailing: Icon(Icons.alarm,
                color: Colors.blue,
              ),
              subtitle: Text('Choose a start time for your meeting'),
              // selected: true,
              onTap: () {
                selectTime(context);

              },
              //leading: Icon(Icons.add),

            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('Meeting End Time',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black
                ),),
              trailing: Icon(Icons.alarm,
              color: Colors.blue,
              ),
              subtitle: Text('Choose an End time for your meeting'),
              // selected: true,
              onTap: () {
                selectTime(context);

              },
              //leading: Icon(Icons.add),

            ),
            SizedBox(
              height: 50,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    activeColor: Colors.blue,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }
                ),
                Text(
                  "Recurring Meeting",
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MeetingTypePage()),
                          );
                        },
                          child: Text("NEXT"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Background color
                            onPrimary: Colors.white, // Text Color (Foreground color)
                          ),


                        ),
                      ],
                    )
                )
              ],
            ),



          ],
        ),


    );
  }

}

formatDate(DateTime dateTime, List list) {
}





