import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TorqueHorsepowerGraph extends StatefulWidget {
  @override
  _TorqueHorsepowerGraphState createState() => _TorqueHorsepowerGraphState();
}

class _TorqueHorsepowerGraphState extends State<TorqueHorsepowerGraph> {
  final TextEditingController _torqueController = TextEditingController();
  final TextEditingController _horsepowerController = TextEditingController();
  final TextEditingController _rpmController = TextEditingController();

  List<FlSpot> _torqueData = [];
  List<FlSpot> _horsepowerData = [];
  List<FlSpot> _rpmData = [];

  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  void _updateChartData() {
    const int dataCount = 100;
    const double maxRpm = 8000;
    const double maxTorque = 300; // Maximum torque value for demo
    const double maxHorsepower = 500; // Maximum horsepower value for demo

    double torque = double.tryParse(_torqueController.text) ?? 0;
    double horsepower = double.tryParse(_horsepowerController.text) ?? 0;
    double rpm = double.tryParse(_rpmController.text) ?? 0;

    _torqueData.clear();
    _horsepowerData.clear();
    _rpmData.clear();

    for (int i = 0; i < dataCount; i++) {
      rpm = (i / dataCount) * maxRpm;

      torque = maxTorque * (1 - pow((rpm / maxRpm), 2));
      horsepower = (torque * rpm) / 5252;

      _rpmData.add(FlSpot(rpm, i.toDouble()));
      _torqueData.add(FlSpot(torque, i.toDouble()));
      _horsepowerData.add(FlSpot(horsepower, i.toDouble()));
    }

    setState(() {}); // Update state to re-render chart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torque & Horsepower vs RPM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _torqueData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: _horsepowerData,
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      axisNameWidget: Text(
                        "Torque (ft-lbs)",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ), // กำหนดให้แสดงหัวข้อด้านซ้าย
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      drawBelowEverything: true,
                      axisNameWidget: Text(
                        "Power (HP)",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ), // กำหนดให้แสดงหัวข้อด้านซ้าย
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      drawBelowEverything: true,
                      axisNameWidget: Text(
                        "RPM (x1000)",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ), // กำหนดให้แสดงหัวข้อด้านซ้าย
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    horizontalInterval: 100,
                    verticalInterval: 50,
                    checkToShowHorizontalLine: (value) => value % 1000 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    ),
                  ),
                  minY: 0,
                  maxY: 600,
                  minX: 0,
                  maxX: 8000,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'RPM',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _torqueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Torque',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _horsepowerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Horsepower',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _rpmController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'RPM',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _updateChartData();
              },
              child: Text('Update Chart'),
            ),
          ],
        ),
      ),
    );
  }
}


