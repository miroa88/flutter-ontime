//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';


class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
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
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                        child: TextField(
                          autofocus: false,
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            fillColor: Colors.white, filled: true,
                            hintText: 'name@example.com',
                          ),
                        ),
                      ),
                    ),
                      SizedBox(height: 20,),


                      //margin: EdgeInsets.only( top: 5),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: width - 40, height: height/16),
                        child:
                        ElevatedButton (
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),),

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
                  child:Image.asset("images/ontime4x.png",
                  scale: 1.8,)

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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    }).catchError((onError) => print(onError.toString()));

  }
}

