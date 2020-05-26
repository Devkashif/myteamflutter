import 'dart:convert';
import 'main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'nwlogin.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
  //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(

        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                          )]
                      ),
                      child: Column(
                        children: <Widget>[

                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  border: InputBorder.none
                              ),
                            ),
                          ),

                          // Text('Selected: ${_stateNameList.name}'),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    Container(

                        width: 150,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: RaisedButton(
                          elevation: 4.3,
                          splashColor: Colors.lightBlueAccent,
                          color: Colors.blue[600],
                          onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(emailController.text, passwordController.text);
                          },
                          child: Text("Sigin",style: TextStyle(color: Colors.white,fontSize: 20),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                        )
                    ),

                    SizedBox(height: 50.0,),
                    Container(

                        width: 250,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: RaisedButton(
                          elevation: 4.3,
                          splashColor: Colors.lightBlueAccent,
                          color: Colors.blue[600],
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LoginNew(),
                            ));
                          },
                          child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                        )
                    ),

                  ],
                ),

              ),
            ),

          ],
        ),

      ),
    );
  }

  signIn(String email, pass) async {
    print("signuin");
    String result;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post("http://newweb.digitalordertechnology.com/odootest/loginUser.php", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        setState(() {

          var convertDataJson = json.decode(response.body);
          result = convertDataJson['message'];

          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => TabActivity()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }


  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();



  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: new Text("Login",
          style: new TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
