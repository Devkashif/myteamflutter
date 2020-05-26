import 'package:flutter/material.dart';

class LoginNew extends StatefulWidget {
  @override
  _LoginNewState createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {

  StateName _stateNameList;
  List<DropdownMenuItem<StateName>> _dropDownMenuItem;
  List<StateName> _statename = StateName.getStateName();

  @override
  void initState() {
    _dropDownMenuItem = buildDropDownMenuItems(_statename);
    _stateNameList = _dropDownMenuItem[0].value;
    super.initState();
  }

  List<DropdownMenuItem<StateName>> buildDropDownMenuItems(List stateName){
    List<DropdownMenuItem<StateName>> items = List();
    for(StateName sn in _statename){
      items.add(DropdownMenuItem(
          value: sn, child: Text(sn.name)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[900],
              Colors.blue[700],
              Colors.blue[400],
            ]
          )
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Signup",style: TextStyle(color: Colors.white,fontSize: 40.0),),
                  ],
                )
            ),
           // SizedBox(height: 20,),
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
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelText: "First Name",
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
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  labelText: "Last Name",
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.numberWithOptions(signed: true),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  labelText: "Mobile Number",
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: DropdownButton(
                                  hint: Text("Chose Your State",style: TextStyle(color: Colors.grey),),
                                  value: _stateNameList,
                                  items: _dropDownMenuItem,
                                  onChanged: onChangeDropDownItem)
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900],width: 1.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10.0)),
                                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  labelText: "City Name",

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

                        width: 200,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: RaisedButton(
                          elevation: 4.3,
                          splashColor: Colors.lightBlueAccent,
                          color: Colors.blue[600],
                          onPressed: (){},
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

  void onChangeDropDownItem(StateName value) {
    setState(() {
      _stateNameList = value;
    });
  }
}

class StateName{
  int id;
  String name;

  StateName(this.id, this.name);

  static List<StateName> getStateName(){
    return<StateName>[

      StateName(1, 'Uttar Pradesh'),
      StateName(2, 'Delhi'),
      StateName(3, 'Madhya Pradesh'),
      StateName(4, 'Maharastra'),
      StateName(5, 'Banglore'),
    ];
  }
}
