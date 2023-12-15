import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:module_04/utils/data_model.dart';
import 'package:module_04/views/view_card.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/database.dart';
import '../utils/feelings.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  List<DataModel> _selectedEvents = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<DataModel> datas = [];

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = _getEventsForDay(_selectedDay!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DataModel> _getEventsForDay(DateTime day) {
    // Implementation example
    return datas.where((e) => isSameDay(e.date, day)).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
    _selectedEvents = _getEventsForDay(selectedDay);
  }

  void _onRefresh() {
    setState(() {
      datas = [];
      _selectedEvents = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database.getDatas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          datas = snapshot.data!;
        }
        return Column(
          children: [
            TableCalendar<DataModel>(
              firstDay: DateTime.utc(1990),
              lastDay: DateTime.utc(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: MediaQuery.of(context).size.height < 600
                  ? CalendarFormat.week
                  : CalendarFormat.month,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: (day) => _getEventsForDay(day),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {},
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _selectedEvents
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      debugPrint(_selectedEvents.indexOf(e).toString());
                                      return viewPopupDialog(
                                          context, e, _onRefresh);
                                    })
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink.shade100,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: CupertinoContextMenu.kEndBoxShadow,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              "${DateFormat.E().format(e.date)} ${DateFormat.d().format(e.date)}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                          Text(DateFormat.LLLL().format(e.date),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                          Text(e.date.year.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Center(
                                            child: Text(e.title,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20))),
                                      )),
                                      Feelings.getIcon(e.feeling)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
