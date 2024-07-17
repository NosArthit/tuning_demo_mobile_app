import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuning_demo/page/register_page.dart';
import 'package:tuning_demo/WifiAccessPoint/wifi_accessPoint_page.dart';
import 'package:tuning_demo/screens/scan_screen.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String _username = 'N/A';
  String _lastname = 'N/A';
  String _email = 'N/A';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'N/A';
      _lastname = prefs.getString('lastname') ?? 'N/A';
      _email = prefs.getString('email') ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: $_username', style: TextStyle(fontSize: 20)),
            Text('Lastname: $_lastname', style: TextStyle(fontSize: 20)),
            Text('Email: $_email', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                ).then((_) {
                  // Refresh user data after returning from register page
                  _loadUserData();
                });
              },
              child: Text('Register'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              child: Text('Bluetooth'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WifiAccessPointPage()),
                );
              },
              child: Text('Wifi-Access Point'),
            ),
          ],
        ),
      ),
    );
  }
}


