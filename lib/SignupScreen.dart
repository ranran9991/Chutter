import 'dart:async';
import 'package:flutter/material.dart';

import 'CredentialsValidator.dart';
import 'Infrastructure/Request.dart';
import 'Controller.dart';

class SignupScreen extends StatefulWidget{
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<SignupScreen>{

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  CredentialsValidator _validator = new NormalCredentialsValidator();
  @override
  void initState(){
    super.initState();

    Controller controller = new Controller();
    Stream<List<int>> socket = controller.broadcastSocket;

    // subscribe to socket data
    StreamSubscription streamSubscription;
    streamSubscription = socket.listen((List<int> data){
      Request request = Request.fromJSON(String.fromCharCodes(data));
      if(request.requestType == RequestType.signupRequest){
        // close subscription when moving to another page
        streamSubscription.cancel();
        Navigator.of(context).pushNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context){

    final username = TextFormField(
      controller: _usernameController,
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a username';
        }
        if(! _validator.isUsernameValid(value)){
          return 'Username is invalid';
        }
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'user name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      validator: (value) {
        if(value.isEmpty){
          return 'Please enter a password';
        }
        if(!_validator.isPasswordValid(value)){
          return 'Password is invalid';
        }
      },
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

  

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            // check if credentials are fine
            if(_formKey.currentState.validate()){
              // send message to server
              Controller controller = new Controller();
              controller.sendSignupRequest(_usernameController.text, _passwordController.text);
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Sign up', style: TextStyle(color: Colors.white)),
        ),
      )
    );

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent.shade50,
        body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text(
              'Sign up',
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 60.0),
              ),
            SizedBox(height: 30.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            signupButton
          ]
        ),
      ),
    ),
    );
  }
}