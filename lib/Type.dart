import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFileDataToFirestoreDatabase(String fileUrl, String title, String type) async {
  try {
    await FirebaseFirestore.instance.collection('BookType').add({
      'fileUrl': fileUrl,
      'title': title,
      'type': type,
    });
    
    print('File data added to Firestore successfully.');
  } catch (error) {
    print('Error adding file data to Firestore: $error');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 

  List<String> fileUrls = [
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2FAlien%20Shop.jpg?alt=media&token=e320a046-2912-49d1-a7c5-214c166dd1ff',
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2Fvillain.jpg?alt=media&token=248be1db-8670-4401-8261-37d29001ad7d',
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2Fตัวร้ายเกรดC.jpg?alt=media&token=351c046f-a1b1-495d-8957-7112f4f9f628',
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2Fราชินีผู้ทรงอำนาจ.png?alt=media&token=ea3db3db-8193-41dd-9fb7-89e79107cf03',
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2Fหลานคุณตาสุดโหด.png?alt=media&token=b44a027e-31aa-42a1-81a1-eaf12620cd3a',
    'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Newbook%2Fเสี่ยวหยูเป็นใบ้.JPG?alt=media&token=4ce20cd9-0a84-462d-9b53-0585a190013e'
  ];

  List<String> titles = [
    'Alien Shop',
    'villain',
    'ตัวร้ายเกรดC',
    'ราชินีผู้ทรงอำนาจ',
    'หลานคุณตาสุดโหด',
    'เสี่ยวหยูเป็นใบ้'
  ];

  List<String> types = [
    'Fantasy',
    'Mystery',
    'Action',
    'Thrilling',
    'Fantasy',
    'Drama'
  ];

  for (int i = 0; i < fileUrls.length; i++) {
    addFileDataToFirestoreDatabase(fileUrls[i], titles[i], types[i]);
  }
}
