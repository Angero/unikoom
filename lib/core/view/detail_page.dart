import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String comment;

  const DetailPage({Key key, this.title, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(this.title, style: TextStyle(fontSize: 22.0),),
              SizedBox(height: 16.0),
              Text(this.comment),
            ],
          ),
        ),
      ),
    );
  }
}