import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestClock extends StatefulWidget {
  const RestClock({
    super.key,
  });

  @override
  State<RestClock> createState() => _RestClockState();
}

class _RestClockState extends State<RestClock> {
  int _milliSec = 0;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliSec += 10;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String timeFormater() {
    var min = 0, sec = 0, milliSec = 0;

    sec = _milliSec ~/ 1000;
    milliSec = (_milliSec % 1000) ~/ 10;
    min = sec ~/ 60;
    sec = sec % 60;

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}:${milliSec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop(timeFormater());
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeFormater(),
                style: const TextStyle(
                  fontFeatures: <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              const Text('TAP for Next Rep!'),
            ],
          ),
        ),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  int _milliSec = 0;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliSec += 10;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String timeFormater() {
    var min = 0, sec = 0, milliSec = 0;

    sec = _milliSec ~/ 1000;
    milliSec = (_milliSec % 1000) ~/ 10;
    min = sec ~/ 60;
    sec = sec % 60;

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}:${milliSec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeFormater(),
      style: const TextStyle(
        fontFeatures: <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
    );
  }
}
