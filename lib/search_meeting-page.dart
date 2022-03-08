import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'contact_info_detail.dart';

class SearchMeeting extends StatefulWidget {
  const SearchMeeting({Key? key}) : super(key: key);

  @override
  _SearchMeetingState createState() => _SearchMeetingState();
}

class _SearchMeetingState extends State<SearchMeeting> {
  @override

  Widget build(BuildContext context) {

    List<String> items = [
      'CS2500',
      'CS6533',
      'CS2144',
    ];

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Meeting")
      ),
      body: Column(

        children: [
          SizedBox(
            height: width/10,
          ),
          Center(
            child: Container(
              width: width - 20,
              height: (width - 20) / 6,
              child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Search Meeting Title, Type and Date',
                    suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {  },

                    )

                  ),
                  autofocus: false

              ),
            ),
          ),
          SizedBox(
            height: width/10,
          ),
          Center(
            child: Text("Recent Searches",
              style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: width/20,
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => ContactInfoDetail(items[index])));
                      },
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
            ),
          )

        ],
      )

    );
  }
}
