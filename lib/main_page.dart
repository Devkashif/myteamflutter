import 'dart:async';
import 'dart:io' as io;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'myteam.dart' as myteam;
import 'myfaimily.dart' as myfaimily;
import 'mytask.dart' as mytask;
import 'itemMenu.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'accounts_profile.dart';

class TaskMsg{

  String texttasksd;

  TaskMsg({this.texttasksd});
}

class TabActivity extends StatefulWidget {


  @override
  _TabActivityState createState() => _TabActivityState();
}

class _TabActivityState extends State<TabActivity> with SingleTickerProviderStateMixin {

  //MedcorderAudio _medcorderAudio = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";

  TabController controller;
  FlutterAudioRecorder recoder;
  Recording _recording;
  Timer _timer;
  Widget _buttonIcon = Icon(Icons.perm_camera_mic,size: 40.0,color: Colors.greenAccent,);
  String _alert;
  String value;
  DateTime _dateTime;
  var _taskmsg = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    controller = new TabController(vsync: this,length: 3);
    super.initState();
    Future.microtask(() => _prepare());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }



  void _opt() async {

    switch(_recording.status){

      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }

      case RecordingStatus.Recording:
        {
          await _StopRecording();
          break;
        }

      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }
      default:
        break;
    }

    setState(() {

      _buttonIcon = _playerIcon(_recording.status);
    });

  }

  Future _init() async {

    String recordingPath = '/flutter_audio_recorder_';
    io.Directory appDocDirectory;
    if(io.Platform.isIOS){
      appDocDirectory = await getApplicationDocumentsDirectory();
    }else {

      appDocDirectory = await getExternalStorageDirectory();
    }

    recordingPath = appDocDirectory.path + recordingPath + DateTime.now().millisecondsSinceEpoch.toString();

    recoder = FlutterAudioRecorder(recordingPath,audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await recoder.initialized;
  }

  Future _prepare() async {

    var hasPermision = await FlutterAudioRecorder.hasPermissions;
    if(hasPermision){
      await _init();
      var result = await recoder.current();
      setState(() {
        _recording = result;
        _buttonIcon = _playerIcon(_recording.status);
        _alert = "";
      });
    }else{
      setState(() {
        _alert = "Permission Required";
      });
    }
  }

  Future _startRecording() async {

    await recoder.start();
    var current = await recoder.current();
    setState(() {
      _recording = current;
    });

    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {

      var current = await recoder.current();
      setState(() {
        _recording = current;
        _timer = t;
      });
    });
  }

  Future _StopRecording() async {
    var result = await recoder.stop();
    _timer.cancel();
    setState(() {
      _recording = result;
    });
  }

  void _play(){

    AudioPlayer player = AudioPlayer();
    player.play(_recording.path, isLocal: true);
  }

  Widget _playerIcon(RecordingStatus status){

    switch(status){
      case RecordingStatus.Initialized:
        {
          return Icon(Icons.fiber_manual_record,color: Colors.red,size: 40.0,);
        }
      case RecordingStatus.Recording:
        {
          return Icon(Icons.stop,size: 40.0,);
        }
      case RecordingStatus.Stopped:
        {
          return Icon(Icons.replay,size: 40.0,);
        }

      default:
        return Icon(Icons.perm_camera_mic,size: 40.0,color: Colors.greenAccent,);
    }
  }

  Future<String> _voiceRecordingDialog(BuildContext context){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: new Text('${_recording?.duration ?? "-"}',style: Theme.of(context).textTheme.body1,),
        content: MaterialButton(
          child: IconButton(
              splashColor: Colors.lightBlue,
              icon: _buttonIcon,
              iconSize: 40.0,
              onPressed: _opt
          ),
        ),
      );

    });

  }

  Future<String> createDialogForSendTask(BuildContext context){

    final dateTimeformat = DateFormat("dd-MM-yyyy HH:mm");
    final dateformat = DateFormat("dd-MM-yyyy");

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Task Created"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(3.0),
                child: SizedBox(height: 40.0,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1.5,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        labelText: "Type your Task",
                        labelStyle: TextStyle(color: Colors.blue)
                    ),
                  ),
                ),
              ),

              Container(
                  margin: EdgeInsets.all(3.0),
                  child: SizedBox(height: 40.0,
                    child: DateTimeField(
                      keyboardType: TextInputType.text,
                      format: dateTimeformat,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1.5,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1.5,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        labelText: "Set Reminder",
                          labelStyle: TextStyle(color: Colors.blue)
                      ),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(

                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  )
              ),

              Container(
                  margin: EdgeInsets.all(3.0),
                  child: SizedBox(height: 40.0,
                    child: DateTimeField(
                      keyboardType: TextInputType.text,
                      format: dateformat,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: "Due Date",
                          labelStyle: TextStyle(color: Colors.blue)
                      ),
                      onShowPicker: (context, currentValue) async {

                          return  showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));

                      },
                    ),
                  )
              ),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              elevation: 10.0,
              splashColor: Colors.lightBlue,
              child: Text("Send"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> mytask.MyTask(value : TaskMsg(texttasksd: _taskmsg.text)),));
              }
          )
        ],
      );
    });
  }

  Future<DateTime> _openDateTimeDialog(BuildContext context) async {

   final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 30)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
    );

   if(date != null){

     final time = await showTimePicker(
         context: context,
         initialTime: TimeOfDay.fromDateTime(DateTime.now()),
     );

     return DateTimeField.combine(date, time);
   }
  }
  void choiceAction(String choices){

    if(choices == ItemMenu.AccountProfile){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Accounts_Profile()));
    }else if(choices == ItemMenu.Logout){
      print("LOgout");
    }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text(
          "Dashboard",
        ),
       actions: <Widget>[
         new PopupMenuButton<String>(
           onSelected: choiceAction,
           itemBuilder: (BuildContext context){
             return ItemMenu.choice.map((String choice){

               return new PopupMenuItem<String>(
                 value: choice,
                 child: Text(choice),
               );
             }).toList();
           },
         )
       ],
       bottom: new TabBar(

         unselectedLabelColor: Colors.white,
         indicator: new BoxDecoration(
           borderRadius: BorderRadius.circular(50.0),
           color: Colors.lightBlue
         ),
         controller: controller,
         tabs: <Widget>[
           new Tab(text: 'My Team',),
           new Tab(text: 'My Faimly',),
           new Tab(text: 'My Task',),
         ],
       ),
      ),
      body: Container(

        child: new TabBarView(
          controller: controller,
          children: <Widget>[
            new myteam.MyTeam(),
            new myfaimily.MyFaimily(),
            new mytask.MyTask()
          ],
        ),
      ),

      floatingActionButton: new SpeedDial(
        curve: Curves.bounceInOut,
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white70,
        animatedIconTheme: IconThemeData.fallback(),
        shape: new CircleBorder(),
        children: [
          new SpeedDialChild(

            child: new Icon(Icons.mic),
            backgroundColor: Colors.lightBlue,
            label: "Send Task",
            onTap: (){
              _voiceRecordingDialog(context);
            },
          ),
          new SpeedDialChild(
              child: new Icon(Icons.message),
              backgroundColor: Colors.lightBlue,
              label: "Send Task",
              onTap: (){
                createDialogForSendTask(context).then((value){
                  SnackBar msnackbar = SnackBar(content: Text("New Task $value"));
                  Scaffold.of(context).showSnackBar(msnackbar);
                });
              },
          )
        ],
      ),


    );

  }
}
