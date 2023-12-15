import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_04/views/Diary.dart';
import 'package:module_04/views/Profile.dart';
import 'package:module_04/views/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String displayName = "";

  void setDisplayName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("No display name"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Please enter a new display name"),
              TextField(
                maxLength: 20,
                onChanged: (String name) {
                  displayName = name;
                },
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!
                      .updateDisplayName(displayName);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.add))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if (FirebaseAuth.instance.currentUser!.displayName == null) {
      Future.microtask(() => setDisplayName());
    }

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/light_bg.jpg"), fit: BoxFit.cover)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: Text(FirebaseAuth.instance.currentUser!.displayName ?? ""),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Future.microtask(() => Navigator.pushNamed(context, "/"));
                    },
                    icon: const Icon(Icons.logout)),
              ]),
          body: const Center(
            child: TabBarView(
              children: [
                Profile(),
                Diary(),
              ],
            ),
          ),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}
