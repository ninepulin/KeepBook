import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keepbook/Toppage.dart';

import 'BookDetailsPage.dart';
import 'Bottom.dart';
import 'BestSeller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: BookshopPage()));
}

class BookshopPage extends StatefulWidget {
  const BookshopPage({Key? key}) : super(key: key);

  @override
  _BookshopPageState createState() => _BookshopPageState();
}

class _BookshopPageState extends State<BookshopPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<Book> bestSellerBooks = [];
  List<Book> newBooks = [];

  List<String> fileNames = [
    'ราชินีผู้ทรงอำนาจ.png',
    'Alien Shop.jpg',
    'villain.jpg',
    'ตัวร้ายเกรดC.jpg',
    'หลานคุณตาสุดโหด.png',
    'เสี่ยวหยูเป็นใบ้.JPG',
  ];

  @override
  void initState() {
    super.initState();
    loadBestSellerImagesIndividually();
    loadNewBookImagesIndividually();
  }

  void loadBestSellerImagesIndividually() {
    List<String> bestSellerFileNames = [
      '100year.png',
      'dog.jpg',
      'elf.png',
    ];

    for (String fileName in bestSellerFileNames) {
      loadSpecificImage('Bestseller/', fileName);
    }
  }

  void loadNewBookImagesIndividually() {
    for (String fileName in fileNames) {
      loadSpecificImage('Newbook/', fileName);
    }
  }

  Future<void> loadSpecificImage(String pathPrefix, String fileName) async {
    try {
      String url = await storage.ref('$pathPrefix$fileName').getDownloadURL();
      setState(() {
        Book book = Book(imageUrl: url, title: fileName.split('.')[0]);
        if (pathPrefix.startsWith('Bestseller/')) {
          bestSellerBooks.add(book);
        } else if (pathPrefix.startsWith('Newbook/')) {
          newBooks.add(book);
        }
      });
    } catch (e) {
      print("Error loading image from $pathPrefix$fileName: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BestSaleCarousel(
              imgList: bestSellerBooks.map((book) => book.imageUrl).toList(),
              bestSaleText: 'Best Seller',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('New!!!',
                      style: Theme.of(context).textTheme.headlineSmall),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Find More'),
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
              ),
              itemCount: newBooks.length,
              itemBuilder: (BuildContext context, int index) {
                Book book = newBooks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          imageUrl: book.imageUrl,
                          bookTitle: book.title,
                          bookContent: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            book.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          book.title,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}

class Book {
  final String imageUrl;
  final String title;

  Book({required this.imageUrl, required this.title});
}
