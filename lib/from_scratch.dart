//login page

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_profile.dart';
import 'main.dart';
import 'list_view.dart';
import 'forgot_pass_page.dart';
import 'register_page.dart';
import 'my_navigation_page.dart';



class FromScratchPage extends StatefulWidget {
  const FromScratchPage({Key? key}) : super(key: key);

  @override
  _FromScratchPageState createState() => _FromScratchPageState();
}

class _FromScratchPageState extends State<FromScratchPage> {


  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),

      //backgroundColor: Colors.indigo[300],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: SizedBox(
                  height: 100,
                ),
                  //child: Image.network('https://wpguynews.com/wp-content/uploads/2021/03/one-click-gmail-login-for-wordpress-featured-image.jpg.webp')
              ),
              Container(

                child: Column(
                  children: [
                     Row(

                        children: [

                            // Container(
                            //   margin: EdgeInsets.only(left: 5, bottom: 30),
                            //   child: Text(
                            //     "Log in",
                            //     style: GoogleFonts.lato(
                            //         textStyle: Theme.of(context).textTheme.headline4,
                            //         fontSize: 30,
                            //         fontWeight: FontWeight.bold,
                            //         fontStyle: FontStyle.normal,
                            //         color: Colors.black
                            //     ),
                            //   ),
                            // ),
                        ],
                      ),
                    Container(
                      width: _width - 10,
                      height: (_width - 10) / 6,
                      child: TextField(
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
                      margin: EdgeInsets.only( top: 5),
                      width: _width - 10,
                      height: (_width - 10) / 6,
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          ),

                          fillColor: Colors.white, filled: true,
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      width: _width - 10,
                      height: (_width - 10) / 7,
                      margin: EdgeInsets.only( top: 5),
                      child: ElevatedButton (
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,

                        ),
                        onPressed: () async{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text)
                              .then((value){
                            print("sgined in seccessfully");
                            // Navigator.push(context,MaterialPageRoute(builder: (context) => MyNavigation(value.user!.uid)));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyNavigation(value.user!.uid)),
                                  (Route<dynamic> route) => false,
                            );
                          }).catchError((onError) => print("sgined in failed"));
                        },
                        child: Text("SIGN IN"),
                      ),
                    ),
                     TextButton(
                        style: TextButton.styleFrom(
                          //padding: const EdgeInsets.all(16.0),
                          primary: Colors.black,
                          //textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPassPage()),);
                        },
                        child: const Text('Forgot Password'),
                      ),




                    // Container(
                    //   //margin: EdgeInsets.only(top: 10, bottom: 10),
                    //   child: TextButton(
                    //     style: TextButton.styleFrom(
                    //       //padding: const EdgeInsets.all(16.0),
                    //       primary: Colors.blue,
                    //       //textStyle: const TextStyle(fontSize: 20),
                    //     ),
                    //     onPressed: () {
                    //      FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //          email: emailController.text,
                    //          password: passController.text)
                    //          .then((value) => print('seccessfully  signed up'))
                    //          .catchError((error) => print("Failed to sign up)"));
                    //     },
                    //     child: const Text('SIGN UP'),
                    //   ),
                    // ),
                    SizedBox(
                      height: 130,
                    ),
                  ],

                ),
              ),

              Container(


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only( top: 5, bottom: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          //padding: const EdgeInsets.all(16.0),
                          primary: Colors.black,
                          //textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const  RegisterPage()),
                          );
                        },
                        child: const Text('Create Account'),
                      ),
                    ),
                    Container(
                      width: 150,

                        child: Image.asset('images/Group.png')
                    )


                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
