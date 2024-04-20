import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keepbook/Toppage.dart';
import 'Bottom.dart';
import 'BookDetailsPage.dart';

class BookshelfPage extends StatelessWidget {
  const BookshelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: const TopAppBar(),
      body: userId == null
          ? const Center(child: Text("Please log in to view your bookshelf."))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bookshelf')
                  .where('userId', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 16.0), 
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailsPage(
                                    imageUrl: data['imageUrl'] ?? '',
                                    bookTitle: data['title'] ?? '',
                                    writerName: data['writerName'] ?? '',
                                    bookContent: data['content'] ?? '',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    data['imageUrl'] ?? '',
                                    width: 100,
                                    height: 150, 
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8), 
                                Expanded(
                                  child: Text(
                                    data['title'] ?? '',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
