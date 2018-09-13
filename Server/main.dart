import 'dart:io';
import 'dart:async';

import 'Server.dart';
import 'ChatMessage.dart';
import '../Infrastructure/Request.dart';

void main(){
  Server server = new Server("C:\Chutter\Infrastructure\config.txt");
  server.Start();
}