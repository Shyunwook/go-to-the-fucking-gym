import 'package:flutter/material.dart';

import '../api/rest_client.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiInterface().getWorkoutRecord(),
        builder: (context, snapshot) {
          print(snapshot.data);
          return Container();
        },
      ),
    );
  }
}
