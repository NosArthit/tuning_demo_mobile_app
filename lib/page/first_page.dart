// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tuning_demo/page/drawer_page.dart';
import 'package:tuning_demo/page/home_page.dart';
import 'package:tuning_demo/page/info_page.dart';
import 'package:tuning_demo/page/user_page.dart';


class FirstPage extends StatefulWidget {
  final int selectedIndex;

  const FirstPage({super.key, required this.selectedIndex});

  @override
  // ignore: library_private_types_in_public_api
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    InfoPage(),
    HomePage(),
    UserPage(),    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(     
        title: Text("GRB Tuninng",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.black87,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.person, color: Colors.white60,),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),   
      drawer: Drawer(
        child: DrawerListPage(),
      ),
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(
            size: 40, 
            color: Colors.black87,
          ),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.query_stats),
              label: 'Info',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User',
            ),
            
          ]
      ),
    );
  }
}


/*
class FirstPage extends StatefulWidget {
  final int selectedIndex;

  const FirstPage({Key? key, this.selectedIndex = 1}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    InfoPage(),
    HomePage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GRB Tuninng",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.black87,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white60,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: DrawerListPage(),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _navigateBottomBar,
      ),
    );
  }
}
*/


