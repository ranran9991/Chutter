import 'dart:io';
import 'dart:async';

import 'Server.dart';
import 'LoginManager.dart';

void main(){
  Server server = new Server("C:\Chutter\Infrastructure\config.txt");
  server.Start();

  
  
  
}