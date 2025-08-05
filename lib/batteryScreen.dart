// ignore_for_file: sort_child_properties_last
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  static const batteryChannel = MethodChannel('battery');

  String _batteryLevel = 'Waiting ...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _batteryLevel,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue.shade900,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 10),
                ),
                child: const Text(
                  'Get Battery Level',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _getBatteryLevel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getBatteryLevel() async {
    String batteryLevel;
    // final int newBatteryLevel =
    //     await batteryChannel.invokeMethod('getBatteryLevel');

    // setState(() {
    //   batteryLevel = '$newBatteryLevel';
    // });

    try {
      final result = await batteryChannel.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
