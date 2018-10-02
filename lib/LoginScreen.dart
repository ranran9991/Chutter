import 'package:flutter/material.dart';

import "ChatScreen.dart";

class LoginScreen extends StatefulWidget{
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen>{
  String _userName = '';
  String _password = '';
  
  @override
  Widget build(BuildContext context){
    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'User name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
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
            // TODO: check if password is fine
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen("Mario"),
              ),
            );
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
            // TODO: check if password is fine
            Navigator.of(context).pushNamed('/signup');
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
}