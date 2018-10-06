import 'package:flutter/material.dart';
import "View.dart";
import "Controller.dart";

void main() async{
  Controller controller = new Controller();
  await controller.initializationDone;
  runApp(new View());
}

