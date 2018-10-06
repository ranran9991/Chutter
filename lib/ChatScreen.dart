import 'package:flutter/material.dart';
import 'dart:async';

import "Infrastructure/Request.dart";
import 'Controller.dart';
import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget{
  final String _name;
  ChatScreen(String name): _name = name;
  _ChatState createState() => new _ChatState(_name);
}

class _ChatState extends State<ChatScreen>{
  final String _name;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  _ChatState(String name): _name = name;

  @override
  void initState(){
    super.initState();

    Controller controller = new Controller();
    Stream<List<int>> socket = controller.broadcastSocket;

    // subscribe to socket data
    StreamSubscription streamSubscription;
    streamSubscription = socket.listen((List<int> data){
      Request request = Request.fromJSON(String.fromCharCodes(data));
      if(request.requestType == RequestType.writeMessageRequest){
        setState(() {
          ChatMessage chatMessage = new ChatMessage(request.args[0], request.args[1], DateTime.now().toLocal());
          _messages.insert(0, chatMessage);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Chutter")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer(){
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                  hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text){
    _textController.clear();
    Controller controller = new Controller();
    controller.sendMessage(this._name, text);
  }
}