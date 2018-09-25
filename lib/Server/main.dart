import 'dart:io';
import 'dart:async';

import 'Server.dart';
import 'LoginManager.dart';

void main(){
  Server server = new Server("config.txt");
  server.Start();
}