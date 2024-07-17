import 'package:flutter/material.dart';
import 'package:tuning_demo/page/rpmTracker.dart';
import 'package:tuning_demo/page/speedTracker_page.dart';
import 'package:tuning_demo/page/torque_power_rpm_page.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Card(
                  elevation: 8,
                  child: SpeedTracker(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Card(
                  elevation: 8,
                  child: RPMTracker(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Card(
                  elevation: 8,
                  child: TorqueHorsepowerGraph(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


