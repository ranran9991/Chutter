import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class ChatMessage extends StatelessWidget {
  final String sender;
  final String content;
  final DateTime timeStamp;

  ChatMessage(this.sender, this.content, this.timeStamp);

  @override
  Widget build(BuildContext context){

    double messageWidth = MediaQuery.of(context).size.width*0.8;
    int hour = timeStamp.toLocal().hour;
    int minute = timeStamp.toLocal().minute;
    String hourString = hour < 10 ? "0" + hour.toString() : hour.toString(); 
    String minuteString = minute < 10 ? "0" + minute.toString() : minute.toString();
    String timeString = hourString + ":" + minuteString;

    return new Container(
      decoration: new BoxDecoration(
        color: const Color(0xffffff),
      
        border: new Border.all(
          color: Colors.lightBlueAccent,
          width: 2.0
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // sender
              new Container(
                margin: const EdgeInsets.only(left: 4.0),
                child: new Text(sender, style: Theme.of(context).textTheme.subhead),
              ),
              // text content
              new Container(
                margin: const EdgeInsets.only(top: 0.5, left: 4.0),
                width: messageWidth,
                child: new Text(content), 
              ),
              // time stamp
              new Container(
                margin: EdgeInsets.only(left: messageWidth),
                child: new Text(timeString, style: new TextStyle(fontSize: 12.0), textAlign: TextAlign.right),
              ),
            ],
          ),
        ],
      )
    );
  }
  String toJSON(){
    var jsonMap = [
      { "sender" : sender},
      { "content" : content},
      { "time_stamp" : timeStamp.toUtc().toIso8601String()}
    ];

    String jsonText = jsonEncode(jsonMap);

    return jsonText;
  }

  static ChatMessage fromJSON(String json){
    var jsonMap = jsonDecode(json);

    return new ChatMessage(jsonMap['sender'], 
                          jsonMap['content'], 
                          DateTime.parse(jsonMap['time_stamp']).toLocal());
  }
}