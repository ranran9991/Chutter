import 'dart:io';
import 'dart:convert';

class ChatMessage {
  String sender;
  String content;
  DateTime timeStamp;

  ChatMessage(this.sender, this.content, this.timeStamp);

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