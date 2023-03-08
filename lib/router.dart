import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_the_fucking_gym/pages/countdown.page.dart';
import 'package:go_to_the_fucking_gym/screens/home.screen.dart';

import 'pages/pages.dart';
import 'screens/screens.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'countdown',
          builder: (BuildContext context, GoRouterState state) {
            return const CountdownPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/workout',
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: WorkoutScreen());
      },
      routes: [
        GoRoute(
          path: ':part/:name',
          builder: (context, state) {
            return SetRepPage(
              workoutName: state.params['name'] ?? '',
              part: state.params['part'] ?? '',
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/day-summary',
      builder: (context, state) {
        return const SummaryScreen();
      },
    ),
  ],
);
