import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_04/utils/data_model.dart';
import '../utils/database.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Stream<QuerySnapshot> _diaryStream =
  FirebaseFirestore.instance.collection('diary').snapshots();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FittedBox(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blueGrey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _diaryStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text("Loading");
                          }

                          return Column(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              DateTime date = DateTime.fromMillisecondsSinceEpoch(data["date"].seconds * 1000);
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(date.day.toString()),
                                      Text(date.month.toString()),
                                      Text(date.year.toString()),
                                    ],
                                  ),
                                  Text(data["feeling"]),
                                  Text(data["title"])
                                ],
                              );
                            }).toList()
                          );
                        },
                      )
                      /*child: FutureBuilder(
                        future: Database.getDatas(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Column(
                              children: snapshot.data!.map((e) => Row(

                                children: [
                                  Column(
                                    children: [
                                      Text(e.date.day.toString()),
                                      Text(e.date.month.toString()),
                                      Text(e.date.year.toString()),
                                    ],
                                  ),
                                  Text(e.feeling),
                                  Text(e.title)
                                ],
                              )).toList(),
                            );
                          }
                          return Text("Loading");
                        },
                      )*/
                    ),
                  ),
                ),
                FittedBox(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        Database.addData(DataModel(DateTime.now(), 'me', "TEST", "TEST", "Sad"));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add new diary")
                        ],
                      ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
