import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/provider/workout.provider.dart';
import 'package:go_to_the_fucking_gym/router.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutController(),
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
