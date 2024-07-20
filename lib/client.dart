import 'dart:convert';
import 'dart:typed_data';

import 'package:udp/udp.dart';
import 'dart:io';
import 'dart:async';

class Client {
  
  String serverIP = 'ipaddress';
  int serverPort = 1234;

  Client(this.serverIP, this.serverPort);

  late UDP socket; //late says the variable will be initialzed later in the code

  var status = 'connecting...';

  Future<void> establish() async {
    try {
      //UDP is connectionless doesn't establish a persistent connection before sending data
      //Only when sending data you specify the servers Ip and the port server is listening in
      socket = await UDP.bind(Endpoint.any(
          port: Port(
              serverPort))); // Bind to any interface It can be bound to any availale network inferfaces like wifi, ethernet, loopback which is localhost
    } catch (e) {
      print("error is $e");
    }
  }

  Future<void> connect() async {
    try {
      //sendMessage("Hey this is Flutter");

      Timer.periodic(const Duration(seconds: 5), (timer) {
        print(DateTime.now());
      });

      String check = await receive();

      print(check);

      if (check == 'connected') {
        print('connected');
        status = 'connected';
      } else {
        print('not connected');
        status = 'Not connected';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> receive() async {
    String message = "me initial";
    final completer = Completer<String>();
    try {
      //"!" will be inizalzed before line executes
      //convert what was socketd into a stream
      //will emit a event
      //listen takes datagram as argument
      //if not null then reads the message
      socket.asStream().listen((datagram) {
        if (datagram != null) {
          message = String.fromCharCodes(datagram.data);
          // Handle socketd message from server (e.g., display in UI)
          completer.complete(
              message); // Complete the completer with the received message
          print('sent from server: $message');

          /*setState(() {
          
        });*/ // Update UI to indicate successful connection
        }
      }).asFuture();
    } catch (e) {
      message = "Got a error";
      print("error is $e");
    }

    return completer.future;
  }

  Future<void> sendMessage(Map<String, bool> message) async {
    //Since socket is UDP? checks to see if null
    //try to send a message encoded with UTF-8
    //broadcast cast to all devices on the network that are listengin on the port

    String jsonData = jsonEncode(message);
    Uint8List dataBytes = Uint8List.fromList(jsonData.codeUnits);
    try {
      //unicast insead of broadcast makesures that it only sends to the specified server addr and port
      var dataLength = await socket.send(dataBytes,
          Endpoint.unicast(InternetAddress(serverIP), port: Port(serverPort)));
      print("sent the map");

      //print('Message sent: $message');
    } catch (e) {
      print('Error sending message: $e');
      // Handle sending errors (e.g., display error message)
    }
  }

  String status_give() {
    return status;
  }
}

class TcpClient {
  String serverIP = 'ipaddress';
  int serverPort = 1234;

  late Socket tcp;

  TcpClient(this.serverIP, this.serverPort);

  Future<void> sendMessage(Map<String, bool> message) async {
    try {
      print("I am sent method");
      tcp = await Socket.connect(serverIP, serverPort);
      String jsonData = jsonEncode(message);
      print(jsonData);
      tcp.write(jsonData);
    } catch (e) {
      print("error ${e}");
    }
  }

  void close() {
    if (tcp != null) {
      tcp!.close();
    }
  }
}
