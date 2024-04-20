import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovelDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> novel;

  const NovelDetailPage({Key? key, required this.novel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = novel.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title'] ?? ''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By: ${data['author'] ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              data['content'] ?? '',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
