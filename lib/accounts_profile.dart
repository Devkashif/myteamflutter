import 'package:flutter/material.dart';
import 'infocard.dart';
import 'package:url_launcher/url_launcher.dart';


const url = 'digitalordertechnology.com';
const email = 'contact@digitalorder.in';
const phone = '+91 6386806049';
const location = 'E3, Rani Jhansi Road, Jhandewalan, New Delhi-110055';

class Accounts_Profile extends StatefulWidget {
  @override
  _Accounts_ProfileState createState() => _Accounts_ProfileState();
}

class _Accounts_ProfileState extends State<Accounts_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/dp.jpg'),
              ),
              
              Text(
                "Digital Order Technology",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif'
                ),
              ),
              Text(
                "Software Company",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.teal[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.teal.shade700,
                ),
              ),
              InfoCard(
                  text: phone,
                  icon: Icons.phone,
                  onPressed: (){
                  },
              ),
              InfoCard(
                text: email,
                icon: Icons.email,
                onPressed: (){
                },
              ),
              InfoCard(
                text: url,
                icon: Icons.web,
                onPressed: () async {
                  if(await canLaunch('http://digitalordertechnology.com/')){

                    await launch('http://digitalordertechnology.com/');
                  }else{
                    print('Error');
                  }
                },
              ),
              InfoCard(
                text: location,
                icon: Icons.location_city,
                onPressed: (){
                },
              ),

            ],
          ),
      ),
    );
  }
}
