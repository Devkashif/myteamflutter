import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main_page.dart';



class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();

  final TaskMsg value;

  MyTask({Key key, this.value}) : super(key : key);
}

class _MyTaskState extends State<MyTask> {



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


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250.0,
            child: ListView.builder(
                itemCount: taskListdata == null ? 0 :taskListdata.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("${taskListdata[index]["id"]}   ${taskListdata[index]["name"]}"),

                        )
                      ],
                    ),
                  );
                }

            ),
          ),

          TaskCreatedByMe()


        ],
      ),
    );
  }
}


class TaskCreatedByMe extends StatefulWidget {
  @override
  _TaskCreatedByMeState createState() => _TaskCreatedByMeState();
}

class _TaskCreatedByMeState extends State<TaskCreatedByMe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.0,

      child: Scaffold(
        appBar: AppBar(
          title: Text("Task Created By Me"),
        ),
        body: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index){

              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(width: 5.0,),
                        Expanded(
                            child: Text("This Section For task Created By Me")
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.play_circle_outline,color: Colors.greenAccent,),
                              label: Text("Play")),
                        ),

                      ],
                    ),
                  ),
                ),

              );
            }
        ),
      )
    );
  }
}
