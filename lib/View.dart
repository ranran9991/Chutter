import 'package:flutter/material.dart';

import "Controller.dart";
import 'LoginScreen.dart';
import 'SignupScreen.dart';

class View extends StatelessWidget{
  @override

  final Controller _cont;
  View(Controller controller) : _cont = controller;

  Widget build(BuildContext ctxt){
    return MaterialApp( 
      home: LoginScreen(),
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/signup' : (context) => SignupScreen(),
      },
    );
  }
}