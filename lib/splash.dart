import 'package:flutter/material.dart';
import 'from_scratch.dart';
//splash
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async{
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FromScratchPage() ));
  }

  @override
  Widget build(BuildContext context) {



    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Splash'),
        ),
        body: Image.asset(
          'images/splashsplash2x.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        )
    );
  }
}


