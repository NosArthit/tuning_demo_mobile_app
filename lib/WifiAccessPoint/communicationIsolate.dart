import 'dart:async';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:tuning_demo/WifiAccessPoint/connectionProvider.dart';

class CommunicationIsolate {
  static Isolate? _isolate;
  static ReceivePort? _receivePort;
  static SendPort? _sendPort;

  static void startIsolate(ConnectionProvider connectionProvider) async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateEntryPoint,
      {'sendPort': _receivePort!.sendPort, 'connectionProvider': connectionProvider},
    );
    _sendPort = await _receivePort!.first;
  }

  static void _isolateEntryPoint(Map<String, dynamic> params) {
    final sendPort = params['sendPort'] as SendPort;
    final connectionProvider = params['connectionProvider'] as ConnectionProvider;
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message['action'] == 'connect') {
        await _connectToESP32(connectionProvider);
      } else if (message['action'] == 'disconnect') {
        _disconnectFromESP32(connectionProvider);
      } else if (message['action'] == 'sendData') {
        await _sendDataToESP32(connectionProvider, message['data']);
      }
    });
  }

  static Future<void> _connectToESP32(ConnectionProvider connectionProvider) async {
    var ip = connectionProvider.ip;
    var url = Uri.parse('http://$ip/connect');  // เปลี่ยนเป็น URL ที่เหมาะสม
    var response = await http.post(url);

    if (response.statusCode == 200) {
      connectionProvider.connect(); // ไม่ต้องส่งพารามิเตอร์ไปยังเมธอด connect()
    } else {
      print('Connection failed with status: ${response.statusCode}.');
    }
  }

  static void _disconnectFromESP32(ConnectionProvider connectionProvider) {
    // ดำเนินการยกเลิกการเชื่อมต่อ
    connectionProvider.disconnect();
  }

  static Future<void> _sendDataToESP32(ConnectionProvider connectionProvider, dynamic data) async {
    var ip = connectionProvider.ip;
    var url = Uri.parse('http://$ip/data');  // เปลี่ยนเป็น URL ที่เหมาะสม
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      print('Data sent successfully.');
    } else {
      print('Sending data failed with status: ${response.statusCode}.');
    }
  }

  static void sendDataToIsolate(Map<String, dynamic> data) {
    if (_sendPort != null) {
      _sendPort!.send(data);
    }
  }

  static void stopIsolate() {
    if (_isolate != null) {
      _isolate!.kill(priority: Isolate.immediate);
      _isolate = null;
      _receivePort = null;
      _sendPort = null;
    }
  }
}
