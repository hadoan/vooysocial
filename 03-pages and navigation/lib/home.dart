import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vooysocial/pages/activity_feed.dart';
import 'package:vooysocial/pages/profile.dart';
import 'package:vooysocial/pages/search.dart';
import 'package:vooysocial/pages/timeline.dart';
import 'package:vooysocial/pages/upload.dart';

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
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
  void dispose() {
    pageController.dispose();
    super.dispose();
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

  onPageChanged(int pageIndex)
  {
    setState(() {
     this.pageIndex = pageIndex; 
    });
  }

  onTap(int pageIndex)
  {
    print('TabBar tapped: $pageIndex!');
    pageController.jumpToPage(pageIndex);
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
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap, 
        activeColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera,size: 35.0,)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle))
        ],
      ),
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