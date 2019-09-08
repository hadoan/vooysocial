import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
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
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account){
        handleSignIn(account);
    },onError: (err){
      print('Error signing in: $err');
    });

    //Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false)
      .then((account){
        handleSignIn(account);
      }).catchError((err){
         print('Error signing in: $err');
      });

  }

  handleSignIn(GoogleSignInAccount account)
  {
    if(account!=null){
          print('User signed in: $account');
          setState(() {
           isAuth = true; 
          });
        }
        else {
          setState(() {
           isAuth = false; 
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    return isAuth? buildAuthScreen():buildUnAuthScreen();
  }

  login(){
    print('login');
    googleSignIn.signIn();
  }

  logout(){
    print('logout...');
    googleSignIn.signOut();
  }

  Widget buildAuthScreen(){
    return RaisedButton(
      child: Text("Logout"),
      onPressed: logout,
    );
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
              Theme.of(context).accentColor.withOpacity(0.8),
              Theme.of(context).primaryColor
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
            'VooySocial',
            style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 40.0,
              color: Colors.white
            ),
          ),
          GestureDetector(
            onTap: login,
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