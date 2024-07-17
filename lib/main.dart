import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuning_demo/WifiAccessPoint/communicationIsolate.dart';
import 'package:tuning_demo/WifiAccessPoint/connectionProvider.dart';
import 'package:tuning_demo/page/first_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConnectionProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // เมื่อ MyApp ถูก build แล้วเราจึงสามารถเรียกใช้ CommunicationIsolate.startIsolate ได้
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommunicationIsolate.startIsolate(Provider.of<ConnectionProvider>(context, listen: false));
    });
    
    return MaterialApp(
      title: "GRB Tuning",
      home: FirstPage(selectedIndex: 1,)
      /*
      routes: {
        '/Info': (context) => InfoPage(),
        '/Home': (context) => HomePage(),
        '/User': (context) => UserPage(),
      },
      */
    );
  }
}







