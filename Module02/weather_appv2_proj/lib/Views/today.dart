import 'package:flutter/cupertino.dart';

class TodayView extends StatefulWidget {
  const TodayView({required this.localisation, super.key});

  final String localisation;

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Today\n${widget.localisation}'));
  }
}
