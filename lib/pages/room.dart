import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'design.dart';
import 'dart:io';
import 'package:get_ip/get_ip.dart';
import 'package:udp/udp.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'designText.dart';

class Room extends StatefulWidget {
  final Design design;

  const Room({Key key, this.design}) : super(key: key);
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool state=false;
  bool state2=false;
  bool state3=false;
  //cache variables
  File jsonFile;
  Directory dir;
  String fileName="myFile.json";
  bool fileExists=false;
  Map< String , dynamic > fileContent;
  TextEditingController keyInputController=new TextEditingController();
  TextEditingController valueInputController=new TextEditingController();

  String destination='192.168.1.121';
  String data,data1;
  int bt1,bt2,bt3,bt4,bt5;
//setState(() {time= "${DateFormat.jm().format(DateTime.now())}";},)

  String time= "${DateFormat.jm().format(DateTime.now())}";
  _triggerUpdate() {
    try{Timer.periodic(Duration(seconds: 1),
            (Timer timer) => (time!="${DateFormat.jm().format(DateTime.now())}")? setState(() {time= "${DateFormat.jm().format(DateTime.now())}";print('time updated');},):null);}catch(e){print('erorrrrr: $e');}
  }

  void receivingData() async {
    String ipAddress = await GetIp.ipAddress;
    var receiver = await UDP.bind(Endpoint.unicast(InternetAddress(ipAddress), port: Port(4210)));
    await receiver.listen((datagram) {
      var str = String.fromCharCodes(datagram.data);
      print(str);
      setState(() {data=str;});
      try{setState(() {
        bt1=int.parse(data[0]);writeToFile('D1',int.parse(data[0]));
        bt2=int.parse(data[1]);writeToFile('D2',int.parse(data[1]));
        bt3=int.parse(data[2]);writeToFile('D3',int.parse(data[2]));
        bt4=int.parse(data[3]);writeToFile('D4',int.parse(data[3]));
        bt5=int.parse(data[4]);writeToFile('D5',int.parse(data[4]));
      });}catch(e){print('error is $e');}
    });
  }
  @override
  void initState(){
    super.initState();
    _triggerUpdate();
    getApplicationDocumentsDirectory().then((Directory directory){
      dir=directory;
      jsonFile=new File(dir.path+"/"+fileName);
      fileExists=jsonFile.existsSync();
      if(fileExists) {this.setState(() => fileContent =json.decode(jsonFile.readAsStringSync()));
      print('here $fileContent');
      bt1=fileContent['D1'];
      bt2=fileContent['D2'];
      bt3=fileContent['D3'];
      bt4=fileContent['D4'];
      bt5=fileContent['D5'];}
      else {
        print('file does not exist');
        createFile({'D1':0,'D2':0,'D3':0,'D4':0,'D5':0}, dir, fileName);
      }
    });

  }
  @override
  void dispose(){
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
  }
  void createFile (Map< String , dynamic > content, Directory dir,String fileName) {
    print('creating file!');
    File file=new File(dir.path +"/"+fileName);
    file.createSync();
    fileExists=true;
    file.writeAsStringSync(json.encode(content));
  }
  void writeToFile( String key ,dynamic value ){
    print('Writing to file!');
    Map<String , dynamic> content ={key: value};
    if(fileExists){
      print('file exists');
      Map<String ,dynamic> jsonFileContent =json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    }
    else {
      print('file does not exist');
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent=json.decode(jsonFile.readAsStringSync()));
  }
  Duration timerXDuration;
  String name1='1';
  String name2='2';
  String name3='3';
  String name4='4';
  String name5='5';
  String nameX,nameXX;
  TextEditingController nameXText=new TextEditingController();
  TextEditingController name1text=new TextEditingController();
  TextEditingController name2text=new TextEditingController();
  TextEditingController name3text=new TextEditingController();
  TextEditingController name4text=new TextEditingController();
  TextEditingController name5text=new TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool pressed=false;
  void _modalBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
      //enableDrag: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),),
      context: context,
      builder: (builder){
        return new Container(
          height: 450,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFe6ebf2),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
            ),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0,10.0,10.0,10.0),
                      height: 35.0,
                      width: MediaQuery.of(context).copyWith().size.width*0.7,
                      decoration: BoxDecoration(
                          color: Color(0xFFe6ebf2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.white.withOpacity(.7)),
                            BoxShadow(
                                offset: Offset(-2, -2),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(.15))
                          ]
                      ),
                      child: TextField(
                        controller: nameXText,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFDCE7F1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Color(0xFFDCE7F1),),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Color(0xFFDCE7F1),),
                            ),
                            hintText: '$nameX'
                        ),
                      ),
                    ),
                    FlatButton(
                        child: Text('Rename'),
                        onPressed: ((){
                          setState(() {
                            nameX=nameXText.text;
                            if(nameXX==name1) {setState((){name1=nameX;});}
                            if(nameXX==name2) {setState((){name2=nameX;});}
                            if(nameXX==name3) {setState((){name3=nameX;});}
                            if(nameXX==name4) {setState((){name4=nameX;});}
                            if(nameXX==name5) {setState((){name5=nameX;});}
                            Navigator.pop(context);
                          });
                        })
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFe6ebf2),
                      border: Border.all(color: Colors.grey[200]),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 3.0,
                            color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                            offset: Offset(-2, -2),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(.15))
                      ]
                  ),
                  child: CupertinoTimerPicker(
                      onTimerDurationChanged: (timeState){
                        print(timeState);
                        setState(() {
                          timerXDuration=timeState;
                        });
                      }
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Set timer on')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Set timer off')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    receivingData();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 10,
            ),
            Text(
              "MyRoom",
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                //fontFamily: "nunito",
              ),
            ),//my home
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height*0.025,
            ),
            Row(
              children: [
                Container(
                  height: 70.0,
                  width: MediaQuery.of(context).copyWith().size.width*0.44,
                  decoration: BoxDecoration(
                      color: Color(0xFFe6ebf2),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-3, -3),
                            color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.black.withOpacity(.15))
                      ]),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFFe6ebf2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Icon(
                              FontAwesome.thermometer_3,
                              color: Colors.black.withOpacity(.5),
                              size: 30.0,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Temp.",
                                style: TextStyle(
                                  //fontFamily: "nunito",
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 15.0)),
                            Text("25 c",
                                style: TextStyle(
                                  //fontFamily: "nunito",
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 15.0))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),//time
                SizedBox(
                  width: MediaQuery.of(context).copyWith().size.width*0.03,
                ),
                Container(
                  height: 70.0,
                  width: MediaQuery.of(context).copyWith().size.width*0.44,
                  decoration: BoxDecoration(
                      color: Color(0xFFe6ebf2),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-3, -3),
                            color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.black.withOpacity(.15))
                      ]),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFFe6ebf2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Icon(
                              FontAwesome.clock_o,
                              color: Colors.black.withOpacity(.5),
                              size: 30.0,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Time",
                                style: TextStyle(
                                  //fontFamily: "nunito",
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 15.0)),
                            Text(time,
                                style: TextStyle(
                                  //fontFamily: "nunito",
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 15.0))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),//temperature
              ],
            ),//temp & time
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height*0.02,
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height*0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFDCE7F1),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 3.0,
                        color: Colors.white.withOpacity(.7)),
                    BoxShadow(
                        offset: Offset(-2, -2),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(.15))
                  ]
              ),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.185,
                children: List.generate(5, (index) => Center(
                  child: InkWell(
                    onTap: (){print('on/off');},
                    onLongPress: (){_modalBottomSheet();},
                    child: Center(
                      child: DesignText(
                        height1: 140,
                        width1: MediaQuery.of(context).copyWith().size.width*0.4,
                        color: Color(0xFFe6ebf2),
                        offsetB: Offset(-2, -2),
                        offsetW: Offset(2, 2),
                        bLevel: 3.0,
                        text: 'device'+(1+index).toString(),
                        iconSize: 20.0,
                        radius: 20,
                      ),
                    ),
                  ),
                ),),
              ),
            ),//list container
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height*0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: (){print('pressed');setState((){state=!state;});},
                      child: Design(
                        height1: 55,
                        width1: 55,
                        color: Color(0xFFe6ebf2),
                        offsetB: Offset(-2, -2),
                        offsetW: Offset(2, 2),
                        bLevel: 3.0,
                        iconData: Icons.wifi,
                        iconSize: 30.0,
                        pressed: state? Colors.blue:Colors.black.withOpacity(0.5),
                      ),
                    ),
                    InkWell(
                      onTap: (){print('pressed2');setState((){state2=!state2;});},
                      child: Design(
                        height1: 55,
                        width1: 55,
                        color: Color(0xFFe6ebf2),
                        offsetB: Offset(-2, -2),
                        offsetW: Offset(2, 2),
                        bLevel: 5.0,
                        iconData: FontAwesome.lightbulb_o,
                        iconSize: 30.0,
                        pressed: state2? Colors.blue:Colors.black.withOpacity(0.5),
                      ),
                    ),
                    InkWell(
                      onTap: (){print('pressed3');setState((){state3=!state3;});},
                      child: Design(
                        height1: 55,
                        width1: 55,
                        color: Color(0xFFe6ebf2),
                        offsetB: Offset(-2, -2),
                        offsetW: Offset(2, 2),
                        bLevel: 5.0,
                        iconData: Icons.home,
                        iconSize: 30.0,
                        pressed: state3? Colors.blue:Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Design(
                      height1: 55,
                      width1: 55,
                      color: Color(0xFFe6ebf2),
                      offsetB: Offset(-2, -2),
                      offsetW: Offset(2, 2),
                      bLevel: 5.0,
                      iconData: FontAwesome.thermometer_quarter,
                      iconSize: 30.0,
                    ),
                  ],
                ),
              ),
            ),//icons
          ],
        ),
      ),
    );
  }
}
