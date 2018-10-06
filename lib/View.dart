import 'package:flutter/material.dart';

import "Controller.dart";
import 'LoginScreen.dart';
import 'SignupScreen.dart';

class View extends StatelessWidget{
  
  @override
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