//register
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var emailController;
    var passController;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

    appBar: AppBar(
    title: const Text('Register'),
    ),


        //backgroundColor: Colors.indigo[300],
        body:ListView(
            children: [
              // Expanded(
              //     flex: 10,
              //     child: SizedBox()
              // ),
              // Expanded(
              //     flex: 20,
              //     child: Center(
                    // child: Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     IconButton(onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //         icon: Image.asset('images/arrow.png')),
                    //     Container(
                    //       margin: EdgeInsets.only(top: 6),
                    //       child: Text(
                    //         "Register",
                    //         style: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
              //     )
              // ),


                  Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: (width - 10) / 6,
                        ),
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
                          height: (width - 10) / 6,
                          //margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: TextField(
                            autofocus: true,
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
                          width: width - 10,

                          height: (width - 10) / 7,
                          margin: EdgeInsets.only( top: 5),
                          child: ElevatedButton (
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,

                            ),
                            onPressed: () {
                              print(width);

                            },
                            child: Text("SIGN UP"),
                          ),
                        ),
                        SizedBox(
                          height: (width - 10) / 6,
                        ),



                      ],
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
}
// Expanded(
// flex: 15,
// child: SizedBox()),
// Expanded(
// flex: 10,
// child:Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// IconButton(
// onPressed: (){},
// icon: Image.asset('images/arrow.png')),//
// Container(
// margin: EdgeInsets.only(top: 6),
// child: Text(
// "Register",
// style: TextStyle(
// fontSize: 30,
// fontWeight: FontWeight.normal,
// ),
// ),
// ),
// ],
// ),
// ),
// Expanded(
// flex: 7,
// child: Container(
// margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
// child: TextField(
// controller: emailController,
// obscureText: false,
// decoration: InputDecoration(
// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.black, width: 2.0),
// ),
// fillColor: Colors.white, filled: true,
//
// labelText: 'name@example.com',
// ),
// ),
// ),
// ),
// Expanded(
// flex: 7,
// child: Container(
// margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
// child: TextField(
// controller: passController,
// obscureText: true,
// decoration: InputDecoration(
// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.black, width: 2.0),
// ),
//
// fillColor: Colors.white, filled: true,
// labelText: 'Password',
// ),
// ),
// ),
//
// ),