import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_04/utils/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static Future<List<DataModel>> getDatas() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    List<DataModel> datas = List.empty(growable: true);

    await db.collection("diary").get().then((event) {
      for (var doc in event.docs) {

        datas.add(DataModel(
            DateTime.fromMillisecondsSinceEpoch(doc.data()["date"].seconds * 1000),
            doc.data()["usermail"],
            doc.data()["title"],
            doc.data()["content"],
            doc.data()["feeling"],
            doc.id));
        debugPrint("${doc.id} => ${doc.data()}");
      }
    });
    return datas;
  }

  static Future<void> addData(DataModel data) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Create a new user with a first and last name
    final newData = <String, dynamic>{
      "date": data.date,
      "title": data.title,
      "content": data.content,
      "feeling": data.feeling,
      "usermail": FirebaseAuth.instance.currentUser!.email
    };

// Add a new document with a generated ID
    db.collection("diary").add(newData).then((DocumentReference doc) =>
        debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
  }

  static Future<void> deleteData(String doc) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    db.collection("diary").doc(doc).delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
  }
}
