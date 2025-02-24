import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DailyReportsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dailyReports = [
    {"date": "2023-10-01", "gamesPlayed": 3, "totalProgress": 70},
    {"date": "2023-10-02", "gamesPlayed": 2, "totalProgress": 50},
    {"date": "2023-10-03", "gamesPlayed": 4, "totalProgress": 90},
    {"date": "2023-10-04", "gamesPlayed": 3, "totalProgress": 80},
  ];

  const DailyReportsPage({Key? key}) : super(key: key); // Add key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Reports"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daily Progress Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Use SizedBox for whitespace
            Expanded(
              child: ListView.builder(
                itemCount: dailyReports.length,
                itemBuilder: (context, index) {
                  final report = dailyReports[index];
                  return Card(
                    child: ListTile(
                      title: Text(report["date"]),
                      subtitle: Text("Games Played: ${report["gamesPlayed"]}"),
                      trailing: Text("Progress: ${report["totalProgress"]}%"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20), // Use SizedBox for whitespace
            const Text(
              "Progress Over Time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Use SizedBox for whitespace
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: dailyReports
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                          entry.key.toDouble(),
                          entry.value["totalProgress"].toDouble()))
                          .toList(),
                      color: Colors.purple, // Use 'color' instead of 'colors'
                      isCurved: true,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(dailyReports[value.toInt()]["date"]);
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