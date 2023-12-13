import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_04/views/Diary.dart';
import 'package:module_04/views/Profile.dart';
import 'package:module_04/views/bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/light_bg.jpg"),
              fit: BoxFit.cover
          )
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("My diary"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Future.microtask(() => Navigator.pushNamed(context, "/"));
                },
                icon: const Icon(Icons.logout)
              ),
            ]
          ),
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
