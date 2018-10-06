
import 'Server.dart';

void main(){
  Server server = new Server("config.json");
  server.start();
}