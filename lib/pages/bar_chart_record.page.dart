import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/dto/dto.dart';

const _surfaceColor = Color(0xff2d4261);
final _highlightColor = Colors.blueGrey[100];

class BarChartRecordPage extends StatefulWidget {
  final String workoutName;
  final Map<String, WorkoutSetDto> data;

  const BarChartRecordPage({
    super.key,
    required this.workoutName,
    required this.data,
  });

  @override
  State<BarChartRecordPage> createState() => _BarChartRecordPageState();
}

class _BarChartRecordPageState extends State<BarChartRecordPage> {
  MapEntry<String, WorkoutSetDto>? selectedData;

  @override
  void initState() {
    super.initState();

    selectedData = widget.data.entries.last;
  }

  String getFormattedDate(String date) {
    return DateFormat('yy.MM.dd').format(DateTime.parse(date));
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: _highlightColor,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        getFormattedDate(
          widget.data.entries.toList()[value.toInt()].key,
        ),
        style: style,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            TextStyle(
              color: _highlightColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      touchCallback: (_, response) {
        if (response?.spot?.touchedBarGroupIndex != null) {
          setState(() {
            selectedData = widget.data.entries.toList()[
                response?.spot?.touchedBarGroupIndex ??
                    widget.data.entries.length];
          });
        }
      });

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<BarChartGroupData> get barGroups => List.generate(
        widget.data.keys.length,
        (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: widget.data.entries.toList()[index].value.weight,
                gradient: _barsGradient,
              ),
            ],
            showingTooltipIndicators: [0],
          );
        },
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue[600]!,
          Colors.tealAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            widget.workoutName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          Container(
            color: const Color(0xff2d4261),
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Padding(
                padding: const EdgeInsets.all(20.0).add(
                  const EdgeInsets.only(
                    top: 50,
                  ),
                ),
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: barGroups,
                    gridData: FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                  ),
                ),
              ),
            ),
          ),
          if (selectedData != null)
            SummaryCard(
              date: selectedData!.key,
              workout: selectedData!.value,
            )
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String date;
  final WorkoutSetDto workout;

  const SummaryCard({
    super.key,
    required this.date,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Performed Info($date)',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: _surfaceColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWithIcon(
                    icon: Icons.repeat,
                    text: workout.reps.toString(),
                  ),
                  TextWithIcon(
                    icon: Icons.fitness_center,
                    text: workout.weight.toString(),
                  ),
                  TextWithIcon(
                    icon: Icons.snooze,
                    text: workout.restTime.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _surfaceColor,
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(
              color: _surfaceColor,
            ),
          ),
        ],
      ),
    );
  }
}
