import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewFaimlyMember extends StatefulWidget {
  @override
  _ViewFaimlyMemberState createState() => _ViewFaimlyMemberState();
}

class _ViewFaimlyMemberState extends State<ViewFaimlyMember> {

  Map data;
  List addedMemberData;

  Future getData() async {
    http.Response response = await http.get("http://newweb.digitalordertechnology.com/odootest/CarMakeLists.php");
    data = json.decode(response.body);

    setState(() {
      addedMemberData = data["data"];
    });
    debugPrint(addedMemberData.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
     appBar: AppBar(
       title: Text("View Faimly Member"),
     ),

     body: Container(

       child: ListView.builder(

         shrinkWrap: true,
           itemCount: addedMemberData == null ? 0 :addedMemberData.length,
           itemBuilder: (BuildContext context, int index){
             return Container(
               width: MediaQuery.of(context).size.width,
               padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
               child: Card(
                 elevation: 5.0,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   child: Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       //crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[

                         SizedBox(width: 5.0,),
                         Expanded(
                             child: Text("${addedMemberData[index]["id"]}   ${addedMemberData[index]["name"]}")
                         ),
                         Container(
                           alignment: Alignment.center,
                           margin: EdgeInsets.only(right: 75.0),
                           child: IconButton(
                               icon: Icon(Icons.call),
                               onPressed: null,
                               splashColor: Colors.lightBlue,
                               disabledColor: Colors.blue,
                           )
                         ),
                         
                         Icon(Icons.remove_red_eye,color: Colors.blue,)
                       ],
                     ),
                   ),
                 ),
               ),

             );
           },
       ),
     ),
   );
  }
}
