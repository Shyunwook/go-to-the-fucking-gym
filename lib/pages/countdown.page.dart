import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  var count = 3;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        count--;
        setState(() {});

        if (count == 0) {
          timer.cancel();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.go('/workout');
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(count.toString()),
      ),
    );
  }
}
