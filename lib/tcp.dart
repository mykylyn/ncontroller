import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class Tcp {
  //late final String serverIp;
  //late final int serverPort;
  late Socket _socket;

  Future<void> connect() async {
    try {
      
      _socket = await Socket.connect("ipaddress", 1234);
      _socket.listen(_dataHandler,
          onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);

      print('Connected to server');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

    void _dataHandler(Uint8List data) {
    print('Received data: ${String.fromCharCodes(data)}');
  }

  void _errorHandler(error, StackTrace trace) {
    print('Error: $error');
    _socket.destroy();
  }

  void _doneHandler() {
    print('Connection closed by server');
    _socket.destroy();
  }

  Future<void> sendMessage(Map<String, bool> message) async {
    String jsonData =  jsonEncode(message);
    try {
       _socket.write("hi");
      print('Message sent: $jsonData');
    } catch (e) {
      print('Error sending message: $e');
      // Handle errors appropriately, e.g., retry, reconnect, etc.
    }
    
    //Uint8List dataBytes = Uint8List.fromList(jsonData.codeUnits);
    
  }

  void closeConnection() {
    _socket.close();
  }
}
