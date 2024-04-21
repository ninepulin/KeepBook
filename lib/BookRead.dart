import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepbook/Bottom.dart';
import 'package:keepbook/Bookshelf.dart'; 

class BookReadPage extends StatelessWidget {
  final String bookId;

  const BookReadPage({
    Key? key,
    required this.bookId,
    required imageUrl,
    required bookContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopApp(), 
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('books').doc(bookId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const Center(
              child: Text('No book content available'),
            );
          }

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
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KEEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BookshelfPage(),
    );
  }
}

class TopApp extends StatelessWidget implements PreferredSizeWidget {
  const TopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text('KEEP'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 125, 161, 197),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
