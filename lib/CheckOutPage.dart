import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepbook/BookRead.dart'; // Import the BookReadPage class
import 'Bottom.dart';

class CheckOutPage extends StatelessWidget {
  final String imageUrl;

  const CheckOutPage({Key? key, required this.imageUrl}) : super(key: key);

  Future<void> _addToBookshelf(BuildContext context) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      await FirebaseFirestore.instance
          .collection('bookshelf')
          .add({
        'imageUrl': imageUrl,
        'userId': userId, 
      });

      print('Book added to bookshelf successfully.');

      List<String> bookIds = ['BOOK_ID_1', 'BOOK_ID_2', 'BOOK_ID_3']; 
      for (String bookId in bookIds) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookReadPage(bookId: bookId)),
        );
      }
    } catch (error) {
      print('Error adding book to bookshelf: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Check Out', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 125, 161, 197),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Items:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.network(
              imageUrl,
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addToBookshelf(context); // Pass the BuildContext to the function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 125, 161, 197),
              ),
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  'Confirm Purchase',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
