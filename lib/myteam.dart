import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyTeam extends StatefulWidget {
  @override
  _MyTeamState createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {

  Map taskdata;
  List taskListdata;

  Future getTaskData() async{

    http.Response response = await http.get("http://newweb.digitalordertechnology.com/odootest/CarMakeLists.php");
    taskdata = json.decode(response.body);

    setState(() {
      taskListdata = taskdata["data"];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskData();
  }

  void _openDateTimeDialog(BuildContext context){
    
    showDatePicker(context: context, initialDate: DateTime.now().add(Duration(days: 30)), firstDate: DateTime.now(), lastDate: DateTime(2100));
  }

  @override
  Widget build(BuildContext context) {
    return Container(

     child: RaisedButton(
         onPressed: () => _openDateTimeDialog(context),
         child: Text("Chose Date"),
     ),
    );
  }
}
