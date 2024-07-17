import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              
              buildAdCard(
                'Top Ranking',
                'Top Ranking Details',
                'https://example.com/ad1.jpg',
              ),

              buildAdCard(
                'โฆษณาที่ 1',
                'รายละเอียดของโฆษณาที่ 1',
                'https://example.com/ad1.jpg',
              ),
              buildAdCard(
                'โฆษณาที่ 2',
                'รายละเอียดของโฆษณาที่ 2',
                'https://example.com/ad2.jpg',
              ),
              // เพิ่มโฆษณาเพิ่มเติมตามต้องการ
              
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAdCard(String title, String description, String imageUrl) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
