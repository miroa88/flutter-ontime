//from listview , each record will be navigated to this page for showing details

import 'package:flutter/material.dart';

class ContactInfoDetail extends StatefulWidget {
   ContactInfoDetail( this.contactDetails, {Key? key}) : super(key: key) ;

  var contactDetails;

  // ContactInfoDetail(this.contactDetails);


  @override
  _ContactInfoDetailState createState() => _ContactInfoDetailState();
}

class _ContactInfoDetailState extends State<ContactInfoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: Column(
        children: [
          Text('${widget.contactDetails.name}'),
          Text('${widget.contactDetails.phoneNumber}'),
          Text('${widget.contactDetails.type}'),
          Text('${widget.contactDetails.avatar}'),
    ],
      ),
    );
  }
}
