// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> addFileDataToFirestoreDatabase(
//     String fileUrl, String title) async {
//   try {
//     await FirebaseFirestore.instance.collection('BookType').add({
//       'fileUrl': fileUrl,
//       'title': title,
//     });

//     print('File data added to Firestore successfully.');
//   } catch (error) {
//     print('Error adding file data to Firestore: $error');
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   List<String> fileUrls = [
//     'https://firebasestorage.googleapis.com/v0/b/mobie-app-325df.appspot.com/o/Text%2Fเกิดใหม่.pdf?alt=media&token=2c9ea538-eaee-4ef5-bac7-28d0d627b95c',
//   ];

//   List<String> titles = [
//     'Dog',
//   ];

//   for (int i = 0; i < fileUrls.length; i++) {
//     addFileDataToFirestoreDatabase(fileUrls[i], titles[i]);
//   }
// }
