import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportPage extends StatelessWidget {
  final List<Map<String, dynamic>> todayReports = [
    {"game": "Trace and Train", "timeTaken": "30s", "progress": 80},
    {"game": "Balloon Burst", "timeTaken": "45s", "progress": 60},
    {"game": "Shape Tracing", "timeTaken": "60s", "progress": 90},
  ];

  // Using 'super.key' for a cleaner constructor
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Adds spacing

            Expanded(
              child: ListView.builder(
                itemCount: todayReports.length,
                itemBuilder: (context, index) {
                  final report = todayReports[index];
                  return Card(
                    child: ListTile(
                      title: Text(report["game"]),
                      subtitle: Text("Time Taken: ${report["timeTaken"]}"),
                      trailing: CircularProgressIndicator(
                        value: report["progress"] / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20), // Adds spacing

            const Text(
              "Progress Chart",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: todayReports
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value["progress"].toDouble(),
                        color: Colors.purple,
                        width: 20,
                      ),
                    ],
                  ))
                      .toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(todayReports[value.toInt()]["game"]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
