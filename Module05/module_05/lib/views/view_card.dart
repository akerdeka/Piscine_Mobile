import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_04/utils/database.dart';
import 'package:module_04/utils/feelings.dart';

import '../utils/data_model.dart';

Widget viewPopupDialog(BuildContext context, DataModel data, refresh) {
  return AlertDialog(
    title: FittedBox(child: Text(DateFormat.yMMMMEEEEd().format(data.date))),
    content: SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: [
              const Text("My feelings: ", style: TextStyle(fontSize: 20),),
              Feelings.getIcon(data.feeling)
            ],
          ),
          Text(data.content)
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.pink.shade100)
        ),
        onPressed: () {
          Database.deleteData(data.docId);
          refresh();
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.delete),
      ),
    ],
  );
}