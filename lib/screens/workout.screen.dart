import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_the_fucking_gym/components/rest_clock.dart';
import 'package:go_to_the_fucking_gym/pages/performed_workout.page.dart';
import 'package:go_to_the_fucking_gym/provider/workout.provider.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<WorkoutController>().startTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Clock(),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const PerformedWorkoutPage();
                },
              );
            },
            icon: const Icon(
              Icons.stacked_line_chart_sharp,
            ),
          )
        ],
      ),
      floatingActionButton: TextButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            Colors.blueGrey,
          ),
        ),
        onPressed: () {
          context.read<WorkoutController>().calculateWokoutVolume();
          context.read<WorkoutController>().endTime = DateTime.now();
          context.go('/day-summary');
        },
        child: const Text(
          'Done WOD',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.grey[800],
              unselectedLabelStyle: const TextStyle(
                color: Colors.grey,
              ),
              tabs: const [
                Tab(
                  text: 'Free Weight',
                ),
                Tab(
                  text: 'Machine',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const WorkoutList(),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Chest'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Bench Press'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push('/workout/CHEST/Bench Press');
                },
                child: const Text('START'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('LEG'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Squat'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push('/workout/LEG/Squat');
                },
                child: const Text('START'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
