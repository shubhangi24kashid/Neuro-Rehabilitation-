import 'package:flutter/material.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Survey")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("We want to know you better!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "Full Name")),
            TextField(decoration: InputDecoration(labelText: "Age")),
            SizedBox(height: 10),
            Text("Gender:"),
            Row(
              children: [
                Checkbox(value: false, onChanged: (val) {}),
                Text("Male"),
                Checkbox(value: false, onChanged: (val) {}),
                Text("Female"),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
