import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends State<Home>{

  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return isAuth? buildAuthScreen():buildUnAuthScreen();
  }

  Widget buildAuthScreen(){
    return Text("Authenticated");
  }

  Widget buildUnAuthScreen()
  {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal,
              Colors.purple
            ]
          )
        ),
        alignment: Alignment.center,
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Text(
            'FlutterSocial',
            style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 40.0,
              color: Colors.white
            ),
          ),
          GestureDetector(
            onTap: ()=>print('tapped'),
            child: Container(
              width: 190.0,
              height: 46.0,
              decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage("assets/images/google_signin_button.png"),
                 fit: BoxFit.cover
               )
              ),
            ),
          )
        ],),
      ),
    );
  }
  
}