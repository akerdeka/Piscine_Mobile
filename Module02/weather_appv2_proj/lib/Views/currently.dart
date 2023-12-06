import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentlyView extends StatefulWidget {
  const CurrentlyView({required this.localisation, super.key});

  final String localisation;

  @override
  State<CurrentlyView> createState() => _CurrentlyViewState();
}

class _CurrentlyViewState extends State<CurrentlyView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Currently\n${widget.localisation}'));
  }
}
