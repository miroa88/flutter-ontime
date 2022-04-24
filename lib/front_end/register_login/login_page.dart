//login page

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/front_end/register_login/varify_email.dart';
import '/front_end/navigation_page.dart';
import 'password_recovery_page.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool invalidPass = false;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('LOGIN')),
      ),

      //backgroundColor: Colors.indigo[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 70,),
              Text("Welcome",
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              SizedBox(height: 20,),
              Image.asset('images/splashsplash2x.png',
                  scale: 1.6),
              SizedBox(height: 60,),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: TextField(
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
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fillColor: Colors.white, filled: true,
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 15,),
              invalidPass ? Text("Invalid password or email",
              style: TextStyle(
                color:  Colors.red,

              )
              ) : Container(),
              SizedBox(height: 15,),
              ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: _width - 40, height: _height/16),
                  child:
                  ElevatedButton(onPressed: () async{
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text)
                        .then((value){
                      print("sgined in seccessfully");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => VerifyEmailPage()),
                            (Route<dynamic> route) => false,
                      );
                    }).catchError((onError){
                      print("sgined in failed");
                      setState(() {
                        invalidPass = true;
                      });

                    });
                  },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),),
                      child: Text("SIGN IN")
                  )
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
                    MaterialPageRoute(builder: (context) => const PasswordRecoveryPage()),);
                },
                child: const Text('Forgot Password',
                style: TextStyle(
                  color: Colors.blue
                ),),
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
                    MaterialPageRoute(builder: (context) => const  RegisterPage()),
                  );
                },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    const Text('Sign Up',
                        style: TextStyle(
                        color: Colors.blue
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
