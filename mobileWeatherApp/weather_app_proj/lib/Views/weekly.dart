import 'package:flutter/cupertino.dart';

class WeeklyView extends StatefulWidget {
  const WeeklyView({required this.localisation, super.key});

  final String localisation;

  @override
  State<WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Weekly\n${widget.localisation}'));
  }
}
