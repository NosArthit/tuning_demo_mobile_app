import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:math';

class RPMTracker extends StatefulWidget {
  @override
  _RPMTrackerState createState() => _RPMTrackerState();
}

class _RPMTrackerState extends State<RPMTracker> {
  final TextEditingController _rpmController = TextEditingController();
  List<FlSpot> _rpmData = [];
  double _currentRPM = 0.0;
  Timer? _timer;

  void _addRPMData(String rpmString) {
    double rpm = double.parse(rpmString); // Convert input string to double
    DateTime now = DateTime.now();

    setState(() {
      _currentRPM = rpm;
      _rpmData.add(FlSpot(now.millisecondsSinceEpoch.toDouble(), rpm));
      if (_rpmData.length > 20) {
        _rpmData.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RPM Tracker'),
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
                      spots: _rpmData,
                      isCurved: true,
                      barWidth: 3,
                      color: const Color.fromARGB(255, 139, 255, 143),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 44),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                        final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        final timeString = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                        return SideTitleWidget(child: Text(timeString), space: 10, axisSide: meta.axisSide);
                      }),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Current RPM: ${_currentRPM.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: _rpmController,
                decoration: InputDecoration(labelText: 'Enter RPM'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addRPMData(_rpmController.text);
              },
              child: Text('Add RPM Data'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RPMTracker(),
  ));
}

