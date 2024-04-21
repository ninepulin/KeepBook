import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepbook/Toppage.dart';
import 'package:keepbook/Bottom.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> bookTypes = [
    'Fantasy',
    'Mystery',
    'Action',
    'Thrilling',
    'Drama',
  ];

  List<String> selectedTypes = [];
  String searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search book by name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: bookTypes.map((type) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedTypes.contains(type)) {
                        selectedTypes.remove(type);
                      } else {
                        selectedTypes.add(type);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: selectedTypes.contains(type)
                          ? const Color.fromARGB(255, 33, 128, 206).withOpacity(0.8)
                          : const Color.fromARGB(255, 111, 172, 226),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: selectedTypes.contains(type)
                            ? Colors.black
                            : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: selectedTypes.isEmpty
                  ? FirebaseFirestore.instance
                      .collection('BookType')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('BookType')
                      .where('type', whereIn: selectedTypes)
                      .snapshots(),
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
                final documents = snapshot.data?.docs ?? [];
                final filteredDocuments = documents.where((doc) {
                  final title = doc['title']?.toString().toLowerCase() ?? '';
                  return title.contains(searchKeyword.toLowerCase());
                }).toList();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final data =
                        filteredDocuments[index].data() as Map<String, dynamic>;
                    final String title = data['title'] ?? '';
                    final String imageUrl = data['fileUrl'] ?? '';
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
