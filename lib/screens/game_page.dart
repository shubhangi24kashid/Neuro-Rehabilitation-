import 'package:flutter/material.dart';
import 'webview_screen.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Selection")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Start Your Finger Rehabilitation Journey", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text("Trace and Train"),
              tileColor: Colors.green[200],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(gamePath: 'assets/trace_train.html'),
                ),
              ),
            ),
            ListTile(
              title: Text("Balloon Burst"),
              tileColor: Colors.grey[300],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(gamePath: 'assets/balloon_burst.html'),
                ),
              ),
            ),
            ListTile(
              title: Text("Shape Tracing"),
              tileColor: Colors.grey[300],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(gamePath: 'assets/shape_tracer.html'),
                ),
              ),
            ),
            ListTile(
              title: Text("Finger Piano"),
              tileColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
