import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuning_demo/WifiAccessPoint/communicationIsolate.dart';
import 'package:tuning_demo/WifiAccessPoint/connectionProvider.dart';
import 'package:tuning_demo/page/first_page.dart';


class WifiAccessPointPage extends StatefulWidget {
  @override
  State<WifiAccessPointPage> createState() => _WifiAccessPointPageState();
}

class _WifiAccessPointPageState extends State<WifiAccessPointPage> {

  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Communication'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FirstPage(selectedIndex: 0,)),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) => connectionProvider.ip = value,
                decoration: InputDecoration(
                  hintText: 'Enter ESP32 IP Address',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!connectionProvider.connected) {
                    CommunicationIsolate.sendDataToIsolate({'action': 'connect'});
                  } else {
                    CommunicationIsolate.sendDataToIsolate({'action': 'disconnect'});
                  }
                },
                child: Text(connectionProvider.connected ? 'Disconnect' : 'Connect'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (connectionProvider.connected) {
                    CommunicationIsolate.sendDataToIsolate({
                      'action': 'sendData',
                      'data': {'command': 'your-command'}
                    });
                  } else {
                    // Handle case when not connected
                  }
                },
                child: Text('Send Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

