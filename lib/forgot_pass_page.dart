//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'from_scratch.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(

          title: Text('Forgot your password'),
        ),

        //backgroundColor: Colors.indigo[300],
        body:  ListView(
              children: [
                // Expanded(
                //     flex: 10,
                //     child: SizedBox()
                // ),
                // Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             IconButton(onPressed: () {
                //
                //               Navigator.pop(context);
                //             },
                //                 icon: Image.asset('images/arrow.png')),
                //             Container(
                //               margin: EdgeInsets.only(top: 10),
                //               child: Text(
                //                 "Forgot your password",
                //                 style: TextStyle(
                //                   fontSize: 25,
                //                   fontWeight: FontWeight.normal,
                //                 ),
                //               ),
                //             ),
                //           ],
                //
                SizedBox(
                  height: 50,
                ),
                Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: width - 10,
                              height: (width - 10) / 6,
                              margin: EdgeInsets.only(bottom: 5),
                              child: TextField(
                                autofocus: true,
                                controller: emailController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  fillColor: Colors.white, filled: true,

                                  labelText: 'name@example.com',
                                ),
                              ),
                            ),

                            Container(
                              width: width - 10,
                              height: (width - 10) / 7,
                              //margin: EdgeInsets.only( top: 5),
                              child: ElevatedButton (
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,

                                ),
                                onPressed: resetPassword,
                                child: Text("GET LINK"),
                              ),
                            ),
                            SizedBox(
                              height: (width - 10) / 6,

                            )



                          ],
                        )
                    ),


                 Center(
                      child: Container(
                          width: width/3,
                          child:Image.asset("images/Group.png")

                      ),
                    )

              ],
            )


    );
  }

  Future resetPassword() async{
    print(emailController.text);
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text).then((value) {
          print("sent link seccesfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  FromScratchPage()),
          );
    }).catchError((onError) => print(onError.toString()));

  }
}

