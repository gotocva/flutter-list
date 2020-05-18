import 'package:flutter/material.dart';
import 'package:flutterlist/http_client/ApiCall.dart';
import 'package:flutterlist/model/User.dart';
import 'package:flutterlist/pages/UserDetail.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'dart:convert';

import 'model/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. MaterialApp(
  // debugShowCheckedModeBanner: false
  //)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ApiCall api = new ApiCall();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("List users")),
      body: new Container(
        child: FutureBuilder(
          future: api.getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return new Container(
               child :  Center(
                 child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.blue,),
               )
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: ListTile(
                        leading: new CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index].image),
                        ),
                        title: new Text(snapshot.data[index].name),
                        subtitle: new Text(snapshot.data[index].email),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => UserDetail(snapshot.data[index].name))
                          );
                        },
                      ),
                    );
                  }
              );
            }
          },
        ),
      ),
    );
  }


}
