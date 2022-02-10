import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';

class Brightness extends StatefulWidget {
  const Brightness({Key? key}) : super(key: key);

  @override
  _BrightnessState createState() => _BrightnessState();
}

class _BrightnessState extends State<Brightness> {
  double brightness = 0.0;
  bool toggle = false;
  @override
  void initState() {
    super.initState();
    initPlatformBrightnsess();
  }

  Future<void> initPlatformBrightnsess() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) {}
    setState(() {
      brightness = bright;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Brightness')),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black26),
              boxShadow: [
                BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 2)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AnimatedCrossFade(
                      firstChild: Icon(
                        Icons.brightness_7,
                        size: 50,
                      ),
                      secondChild: Icon(
                        Icons.brightness_3,
                        size: 50,
                      ),
                      crossFadeState: toggle
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(seconds: 1)),
                  Expanded(
                    child: Slider(
                      value: brightness,
                      onChanged: (value) {
                        setState(() {
                          brightness = value;
                        });
                        FlutterScreenWake.setBrightness(brightness);
                        if (brightness == 0) {
                          toggle = true;
                        } else {
                          toggle = false;
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
