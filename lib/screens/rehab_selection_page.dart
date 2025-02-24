import 'package:flutter/material.dart';
import 'game_page.dart';

class RehabSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rehab Selection")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select the specific area you'd like to focus on", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text("Fingers"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameSelectionPage()),
                );
              },
            ),
            ListTile(title: Text("Wrist")),
            ListTile(title: Text("Elbow")),
            ListTile(title: Text("Shoulder")),
          ],
        ),
      ),
    );
  }
}
