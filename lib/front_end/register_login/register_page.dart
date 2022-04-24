//register
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool passMatched = false;
  bool obsecurePass = true;
  bool obsecurePassRepeat = true;
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool hasMinLength = false;
  bool emailValid = false;

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(

        appBar: AppBar(),

        body:SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text("SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(height: 15,),

                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  child: TextField(
                    style: TextStyle(color: emailValid ? Colors.black : Colors.red),
                    onChanged: (email) {
                      setState(() {
                        emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      });
                    },
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
                    onChanged: (password){
                      setState(() {
                        hasUppercase = password.contains(RegExp(r'[A-Z]'));
                        hasDigits = password.contains(RegExp(r'[0-9]'));
                        hasLowercase = password.contains(RegExp(r'[a-z]'));
                        hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                        hasMinLength = password.isNotEmpty && password.length > 7;
                      });

                    },
                    controller: passController,
                    obscureText: obsecurePass,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white, filled: true,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            if(obsecurePass){
                              obsecurePass = false;
                            }
                            else {
                              obsecurePass = true;
                            }
                          });
                        },
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  child: TextField(
                    style: TextStyle(color: passMatched ? Colors.black : Colors.red),
                    onChanged: (text) {
                      if(text == passController.text) {
                        setState(() {
                          passMatched = true;
                        });
                      }
                      else {
                        setState(() {
                          passMatched = false;
                        });
                      }
                    },
                    obscureText: obsecurePassRepeat,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white, filled: true,
                      hintText: 'Repeat Password',
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            if(obsecurePassRepeat){
                              obsecurePassRepeat = false;
                            }
                            else {
                              obsecurePassRepeat = true;
                            }
                          });
                        },
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top:10, bottom: 20),
                  child:Column(
                    children: [
                      Container(
                          height: _height/30,
                          width: _width/2,
                        child: Center(child: Text("At least 1 uppercase letter")),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white10,
                          ),
                          color: hasUppercase ? Colors.green : Colors.white10,
                      )),
                      Container(
                          height: _height/30,
                          width: _width/2,
                        child: Center(child: Text("At least 1 lowercase letter")),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white10,
                            ),
                            color: hasLowercase ? Colors.green : Colors.white10,
                      )),
                      Container(
                          height: _height/30,
                          width: _width/2,
                        child: Center(child: Text("At least 1 special character")),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white10,
                            ),
                            color: hasSpecialCharacters ? Colors.green : Colors.white10,
                      )),
                      Container(
                          height: _height/30,
                          width: _width/2,
                        child: Center(child: Text("At least 1 numerical number")),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white10,
                            ),
                            color:  hasDigits ? Colors.green : Colors.white10,
                      )),
                      Container(
                        height: _height/30,
                        width: _width/2,
                        child: Center(child: Text("At least 8 characters")),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white10,
                          ),
                          color: hasMinLength? Colors.green : Colors.white10,
                        ),
                      ),
                   ],
                  )
                ),
                ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: _width - 40, height: _height/16),
                    child:
                    ElevatedButton(onPressed: (){
                      if(passMatched && hasUppercase && hasDigits && hasLowercase
                          && hasSpecialCharacters && hasMinLength && emailValid) {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text,
                        ).then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                          );
                        }).catchError((e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          } else{
                            print(e);
                          }});
                      }
                    },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),),
                        child: Text("SIGN UP")
                    )
                ),
                SizedBox(height: 30,),

                TextButton(
                  style: TextButton.styleFrom(
                    //padding: const EdgeInsets.all(16.0),
                    primary: Colors.black,
                    //textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const  LoginPage()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a user? "),
                      const Text('LOGIN',
                          style: TextStyle(
                              color: Colors.blue
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Image.asset("images/ontime4x.png",
                  scale: 3,)
              ],
            ),
          ),
        )
    );
  }
}
