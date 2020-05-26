import 'package:flutter/material.dart';
import 'dart:async';
import 'nwlogin.dart';
import 'login.dart';
import 'main_page.dart';


void main() => runApp(new MaterialApp(

  theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.lightBlueAccent),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),

));


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3),(){

      Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage(),
      )
      );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child:  Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: new Icon(
                          Icons.verified_user,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 10.0),
                      ),
                      new Text(
                        "My Team",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    new Text(
                        "Easy to Work \n Easy To Use",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


