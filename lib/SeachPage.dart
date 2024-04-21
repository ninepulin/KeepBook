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

  String selectedType = '';
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
              children: bookTypes.map((type) {
                return FilterChip(
                  label: Text(type),
                  selected: selectedType == type,
                  onSelected: (selected) {
                    setState(() {
                      selectedType = selected ? type : '';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.grey[300],
                  selectedColor: Colors.blue,
                  labelStyle: const TextStyle(color: Colors.black),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('BookType')
                  .where('type', isEqualTo: selectedType)
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
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
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
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
