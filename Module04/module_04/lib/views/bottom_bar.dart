import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const TabBar(
          unselectedLabelColor: Colors.blueGrey,
          indicatorColor: Colors.black,

          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
            ),
          ]),
    );
  }
}
