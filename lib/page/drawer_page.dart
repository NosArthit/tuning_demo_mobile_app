import 'package:flutter/material.dart';
import 'package:tuning_demo/page/user_page.dart';

class DrawerListPage extends StatefulWidget {
  const DrawerListPage({super.key});

  @override
  State<DrawerListPage> createState() => _DrawerListPageState();
}

class _DrawerListPageState extends State<DrawerListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Column(   
              children: [          
                
                SizedBox(height: 25),
            
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return UserPage();
                  }));
                }, child: Text('Change profile picture', style: TextStyle(color: Colors.black87),)),
     
              ],
            ),
          ),
        ),
    );
  }
}