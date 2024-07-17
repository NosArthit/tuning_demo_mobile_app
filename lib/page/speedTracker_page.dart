import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:math';

class SpeedTracker extends StatefulWidget {
  @override
  _SpeedTrackerState createState() => _SpeedTrackerState();
}

class _SpeedTrackerState extends State<SpeedTracker> {
  final TextEditingController _gpsController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  List<FlSpot> _speedData = [];
  double _currentSpeed = 0.0;
  DateTime? _initialTime; // get initial Time

  void _addSpeedData(String gps, String time) {
    // สุ่มค่าความเร็วเพื่อการทดสอบ สามารถปรับให้ใช้คำนวณจาก gps ได้
    double speed = Random().nextDouble() * 100; // Random speed for demo
    DateTime dateTime = _parseDateTime(time);

    if (_initialTime == null) {
      _initialTime = dateTime;
    }

    double timeDifference = dateTime.difference(_initialTime!).inSeconds.toDouble();

    setState(() {
      _currentSpeed = speed;
      _speedData.add(FlSpot(timeDifference, speed));
      if (_speedData.length > 20) {
        _speedData.removeAt(0);
      }
    });
  }

  DateTime _parseDateTime(String dateTimeString) {
    List<String> parts = dateTimeString.split(':');
    return DateTime(
      int.parse(parts[0]), // year
      int.parse(parts[1]), // month
      int.parse(parts[2]), // day
      int.parse(parts[3]), // hour
      int.parse(parts[4]), // minute
      int.parse(parts[5]), // second
      int.parse(parts[6]), // millisecond
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _speedData,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.cyan,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 44),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            child: Text("${value.toInt()}s"),
                            space: 10,
                            axisSide: meta.axisSide,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Current Speed: ${_currentSpeed.toStringAsFixed(2)} km/h',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: _gpsController,
                decoration: InputDecoration(labelText: 'GPS (latitude,longitude)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time (yyyy:mm:dd:hh:mm:ss:msmsms)'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addSpeedData(_gpsController.text, _timeController.text);
              },
              child: Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}









