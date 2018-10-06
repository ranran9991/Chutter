import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import "ChatScreen.dart";
import "Controller.dart";
import "Infrastructure/Request.dart";

class LoginScreen extends StatefulWidget{
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen>{
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  StreamSubscription socketConnection;
  
  @override
  void initState(){
    super.initState();
    
    Controller controller = new Controller();
    Stream<List<int>> socket = controller.broadcastSocket;
    // subscribe to socket data
    socketConnection = socket.listen((List<int> data){
      Request request = Request.fromJSON(String.fromCharCodes(data));
      if(request.requestType == RequestType.loginRequest){
        // close subscription when moving to another page
        socketConnection.cancel().then((_){
          String username = request.args[0];
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(username),
              ),
            );
        });
      }
    });
  }
  @override
  Widget build(BuildContext context){
    final username = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'User name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            Controller controller = new Controller();
            controller.sendLoginRequest(_usernameController.text, _passwordController.text);
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      )
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightGreenAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            // close stream subscription
            socketConnection.cancel().then((_){
              Navigator.of(context).pushNamed('/signup');
            });
          },
          color: Colors.lightGreenAccent,
          child: Text('Don\'t have an account? Sign up!', style: TextStyle(color: Colors.white)),
        ),
      )
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text(
              'Chutter',
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 60.0, fontFamily: '5thgradecursive'),
              ),
            SizedBox(height: 30.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            signupButton
          ]
        ),
      ),
    );
  }
  @override
  void dispose() async{
    super.dispose();
    await socketConnection.cancel();
  }
}