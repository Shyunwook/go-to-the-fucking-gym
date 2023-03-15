import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/countdown');
              },
              child: const Text('GO TO THE FUCKING GYM'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/record-day');
              },
              child: const Text('GO TO THE RECORD(DAY)'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/record-workout');
              },
              child: const Text('GO TO THE RECORD(workout)'),
            ),
          ],
        ),
      ),
    );
  }
}
