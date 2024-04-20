// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:keepbook/Bottom.dart'; 

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  List<String> bookTypes = [
    'Fiction', 'Non-Fiction', 'Biography',
    'Science Fiction', 'Fantasy', 'Mystery',
    'Romance', 'Historical', 'Thriller',
    'Young Adult', 'Children\'s', 'Self-Help',
  
  ];

  List<String> selectedBookTypes = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('KEEP'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 125, 161, 197),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                
              },
              decoration: InputDecoration(
                hintText: 'Search books...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                prefixIcon: const Icon(Icons.search,size: 30),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 242, 233),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: bookTypes.length,
              itemBuilder: (context, index) {
                final type = bookTypes[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedBookTypes.contains(type)) {
                        selectedBookTypes.remove(type);
                      } else {
                        selectedBookTypes.add(type);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedBookTypes.contains(type) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      type,
                      style: TextStyle(
                        color: selectedBookTypes.contains(type) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(), 
    );
  }
}
