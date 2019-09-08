import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

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
       print("SignIn error!: $err"); 
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account){
      handleSignIn(account);
    }).catchError((err){
      print("SignIn error!: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuth? buildAuthScreen():buildUnAuthScreen();
  }

  logout(){
    print('logout');
    googleSignIn.signOut().then((account){
      handleSignIn(account);
    }).catchError((err){
      print("SignOut error!: $err");
    });
  }

  login()
  {
    googleSignIn.signIn().then((GoogleSignInAccount account){
      print("Signed account: $account");
      handleSignIn(account);
    }).catchError((err){
      print("SignIn error!: $err");
    });
  }

  handleSignIn(GoogleSignInAccount account)
  {
    if(account!=null)
    {
      setState(() {
       isAuth = true; 
      });
    }
    else
    {
      setState(() {
       isAuth = false; 
      });
    }
  }

  Widget buildAuthScreen(){
    return RaisedButton(
      onPressed: logout,
      child: Text("Logout"),
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
              Theme.of(context).accentColor,
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