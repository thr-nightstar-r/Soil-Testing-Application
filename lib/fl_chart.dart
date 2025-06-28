import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:geotech_directorate_page/main.dart';

class LineChartSimple extends StatelessWidget {
  final List<double> x3;

  const LineChartSimple({super.key, required this.x3});

  @override
  Widget build(BuildContext context) {
    final List<double> xValues = [100, 80, 63, 42, 27, 13, 10, 6, 3];
    final List<double> y1Values = [40, 20, 10, 4.75, 2, .6, 0.425, 0.212, 0.075];
    final List<double> x3Values = [100, 100, 85, 68, 52, 35, 32, 22, 10];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text('Y Axis'),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text('X Axis'),
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(xValues.length, (index) {
                        return FlSpot(xValues[index], y1Values[index]);
                      }),
                      isCurved: true,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      color: Colors.blue,  // Color for y1 data
                    ),
                    LineChartBarData(
                      spots: List.generate(xValues.length, (index) {
                        return FlSpot(xValues[index], x3[index]);
                      }),
                      isCurved: true,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      color: Colors.red,  // Color for x2 data
                    ),
                    LineChartBarData(
                      spots: List.generate(xValues.length, (index) {
                        return FlSpot(xValues[index], x3Values[index]);
                      }),
                      isCurved: true,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      color: Colors.green,  // Color for x3 data
                    ),
                  ],
                  lineTouchData: const LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(

                    ),
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 0,
                        color: Colors.black,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      ),
                    ],
                    verticalLines: [
                      VerticalLine(
                        x: 0,
                        color: Colors.black,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Indicator(color: Colors.blue, text: 'weight', isSquare: false),
                Indicator(color: Colors.red, text: 'User Entered Data', isSquare: false),
                Indicator(color: Colors.green, text: 'weigth', isSquare: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: isSquare ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
