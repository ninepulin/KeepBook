import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookReadPage extends StatelessWidget {
  final String bookId;

  const BookReadPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Content'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('books').doc(bookId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final data = snapshot.data?.data() as Map<String, dynamic>;

          final bookContent = data['content'] ?? '';

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Text(
              bookContent,
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
