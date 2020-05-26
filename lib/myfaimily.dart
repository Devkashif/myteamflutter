import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'viewfaimlymember.dart';


class MyFaimily extends StatefulWidget {
  @override
  _MyFaimilyState createState() => _MyFaimilyState();
  
  
}

class _MyFaimilyState extends State<MyFaimily> {
  int curentIndex = 0;

  Future<String> createDialogForSendTask(BuildContext context){

    TextEditingController inputcontroler = TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Type here Your Task"),
        content: TextField(
          controller: inputcontroler,
        ),
        actions: <Widget>[
          MaterialButton(
              elevation: 5.0,
              child: Text("Send"),
              onPressed: (){
                Navigator.of(context).pop(inputcontroler.text.toString());
              }
          )
        ],
      );
    });
  }

  int currentIndex = 0;
  onTapped(int index){
    currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250.0,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(6, (index){

                    return new Card(

                      elevation: 10.0,
                      child: new Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: new Text(
                            "$index",
                            style: new TextStyle(
                                fontSize: 24.0
                            ),
                          ),
                        ),
//
                      ),
                    );
                  }),
                ),
              ),
              OverDue(),
            ],
          ),

          bottomNavigationBar: BottamNavItem(),

        );
  }
}

class OverDue extends StatefulWidget {
  @override
  _OverDueState createState() => _OverDueState();
}

class _OverDueState extends State<OverDue> {

  FlutterTts _flutterTts = FlutterTts();
  String text = "Your Fee is Due On 1st March 2019";

  @override
  Widget build(BuildContext context) {

    Future speak() async{
      
      await _flutterTts.setLanguage("hi_IN");
      await _flutterTts.setPitch(1);
      await _flutterTts.speak(text);

    }

    return Container(

      width: double.infinity,
      height: 250.0,
      child: Scaffold(
        
        appBar: AppBar(title: Text("OverDue"),),
        
        body: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context,int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(width: 5.0),
                    Expanded(child: Text(text,style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold))),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton.icon(
                          onPressed: () => speak(),
                          icon: Icon(Icons.play_circle_outline,color: Colors.greenAccent,),
                          label: Text("Play")),
                    )
                  ],
                ),
              ),
            ),
          ),


        ),
      ),
    );
  }
}

class BottamNavItem extends StatelessWidget {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<String> createDialogForSendTask(BuildContext context){

    TextEditingController inputcontroler = TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Add Your Faimly Member"),
        content:  Form(
            key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.all(3.0),
                     child: SizedBox(
                       height: 40.0,
                       child: TextFormField(
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 gapPadding: 20.0,
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),),
                             ),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 gapPadding: 20.0,
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),)
                             ),
                             labelText: "Firest Name"
                         ),
                         maxLines: 1,
                       ),
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.all(3.0),
                     child: SizedBox(
                       height: 40.0,
                       child: TextFormField(
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),)
                             ),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),)
                             ),
                             labelText: "Last Name"
                         ),
                         maxLines: 1,
                       ),
                     ),
                   ),

                   Container(
                     margin: EdgeInsets.all(3.0),
                     child: SizedBox(
                       height: 40.0,
                       child: TextFormField(
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration(

                             enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),)
                             ),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.indigo,
                                   width: 1.5,
                                   style: BorderStyle.solid,
                                 ),
                                 borderRadius: BorderRadius.all(Radius.circular(15.0),)
                             ),
                             prefixIcon: Icon(Icons.call,color: Colors.black,),
                             prefixText: "+91",
                             prefixStyle: TextStyle(color: Colors.black),
                             labelText: "Mobile Number"
                         ),
                       ),
                     ),
                   )

                 ],
                ),
              ),

        ),
        actions: <Widget>[
          MaterialButton(
              elevation: 5.0,
              child: Text("Add"),
              onPressed: (){
                Navigator.of(context).pop(inputcontroler.text.toString());
              }
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
             FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewFaimlyMember()),
                  );
                },
                icon: Icon(Icons.remove_red_eye,color: Colors.white,),
                label: Text("View Member",style: TextStyle(color: Colors.white),),
                color: Colors.lightBlue,
                splashColor: Colors.white,

              ),

            FlatButton.icon(

              onPressed: () => createDialogForSendTask(context),
                  icon: Icon(Icons.group_add,color: Colors.white,),
                  label: Text("Add Member",style: TextStyle(color: Colors.white),),
                  color: Colors.lightBlue,
                  splashColor: Colors.white,

              ),

          ],
        ),
    );
  }
}



