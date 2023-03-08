import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/rest_clock.dart';
import '../provider/workout.provider.dart';
import '../utils.dart';

typedef SetProformSet = void Function({
  required double weight,
  required int rep,
  required WeightUnit unit,
});
typedef SetRestToSet = void Function({required String restTime});

enum WeightUnit {
  kg,
  lb,
}

class SetRepPage extends StatefulWidget {
  final String workoutName;
  final String part;

  const SetRepPage({
    super.key,
    required this.workoutName,
    required this.part,
  });

  @override
  State<SetRepPage> createState() => _SetRepPageState();
}

class _SetRepPageState extends State<SetRepPage> {
  var performs = <PerformSet>[];

  @override
  void initState() {
    super.initState();

    var prevPerformedList = context
            .read<WorkoutController>()
            .performedWorkoutMap[widget.part]?[widget.workoutName] ??
        [];

    if (prevPerformedList.isNotEmpty) {
      performs = [...prevPerformedList];
    }
  }

  @override
  Widget build(BuildContext context) {
    var workoutController = context.watch<WorkoutController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.workoutName),
      ),
      body: Column(
        children: [
          RegistCard(
            onCompleted: ({
              required int rep,
              required double weight,
              required WeightUnit unit,
            }) {
              var newSet = PerformSet(
                kg: unit == WeightUnit.kg ? weight : null,
                lb: unit == WeightUnit.lb ? weight : null,
                reps: rep,
                setCount: performs.length + 1,
                workoutName: widget.workoutName,
                part: widget.part,
                isKillogram: unit == WeightUnit.kg,
              );
              performs.add(newSet);

              workoutController.setPerformedWorkout(newSet);
            },
            onDoneRest: ({required restTime}) {
              workoutController.setRestTimeToWorkout(
                workoutName: widget.workoutName,
                part: widget.part,
                restTime: restTime,
              );
            },
            lastWorkout: workoutController.getLastWorkout(
              part: widget.part,
              workoutName: widget.workoutName,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var set = performs[index];
                return RepCard(
                  set: set,
                );
              },
              itemCount: performs.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: TextButton(
        child: const Text('Next WorkOut'),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}

class RepCard extends StatelessWidget {
  final PerformSet set;

  const RepCard({
    super.key,
    required this.set,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Set ${set.setCount.toString()}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                if (set.restTime.isNotEmpty)
                  Text(
                    'RestTime: ${set.restTime}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  '${Utils.decimalParser(set.kg!)}kg (${Utils.decimalParser(set.lb!)}lb)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  '${set.reps} reps',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RegistCard extends StatefulWidget {
  final SetProformSet onCompleted;
  final SetRestToSet onDoneRest;
  final PerformSet? lastWorkout;

  const RegistCard({
    super.key,
    required this.onCompleted,
    required this.onDoneRest,
    this.lastWorkout,
  });

  @override
  State<RegistCard> createState() => _RegistCardState();
}

class _RegistCardState extends State<RegistCard> {
  WeightUnit unit = WeightUnit.kg;

  TextEditingController _setTextController = TextEditingController();
  late TextEditingController _weightTextController;
  late TextEditingController _repTextController;

  @override
  void initState() {
    super.initState();

    unit = (widget.lastWorkout?.isKillogram ?? true)
        ? WeightUnit.kg
        : WeightUnit.lb;

    _weightTextController = TextEditingController(
      text: widget.lastWorkout?.kg == null
          ? null
          : Utils.decimalParser((widget.lastWorkout?.isKillogram ?? true)
                  ? widget.lastWorkout!.kg!
                  : widget.lastWorkout!.lb!)
              .toString(),
    );
    _repTextController = TextEditingController(
      text: widget.lastWorkout?.reps.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Record New Set'),
                const Spacer(),
                Row(
                  children: [
                    SegmentedButton<WeightUnit>(
                      segments: const [
                        ButtonSegment<WeightUnit>(
                          value: WeightUnit.kg,
                          label: Text('kg'),
                        ),
                        ButtonSegment<WeightUnit>(
                          value: WeightUnit.lb,
                          label: Text('lb'),
                        ),
                      ],
                      selected: <WeightUnit>{unit},
                      onSelectionChanged: (Set<WeightUnit> newUnit) {
                        setState(() {
                          unit = newUnit.first;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        'Set',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        'Weight (${unit.name})',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Text(
                        'Rep',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          ((widget.lastWorkout?.setCount ?? 0) + 1).toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _weightTextController,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _repTextController,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    widget.onCompleted(
                      weight: double.parse(_weightTextController.value.text),
                      rep: int.parse(_repTextController.value.text),
                      unit: unit,
                    );

                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      useRootNavigator: false,
                      builder: (context) {
                        return const Dialog(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: RestClock(),
                        );
                      },
                    ).then(
                      (value) {
                        if (value != null) {
                          widget.onDoneRest(
                            restTime: value,
                          );
                        }
                      },
                      // 초기화
                    );
                  },
                  child: const Text('COMPLETE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
