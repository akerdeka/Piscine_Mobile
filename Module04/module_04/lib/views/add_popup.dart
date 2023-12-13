import 'package:flutter/material.dart';
import 'package:module_04/utils/data_model.dart';
import 'package:module_04/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_04/utils/feelings.dart';
import 'package:selectable_list/selectable_list.dart';

Widget addPopupDialog(BuildContext context) {

  DataModel data = DataModel(DateTime.now(), FirebaseAuth.instance.currentUser!.email, "", "", "", "");

  String selectedFeeling;

  return AlertDialog(
    title: const Text('Add new entry'),
    content: SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              onChanged: (String text) {
                data.title = text;
              },
            ),
            /*SelectableList<Map<Icon, String>>(
              items: Feelings.feelings.values.toList(),
              itemBuilder: (context, icon, selected, onTap) => ListTile(
                  title: icon,
                  subtitle: Text("resr"),
                  selected: selected,
                  onTap: onTap),
              valueSelector: (icon) => icon,
              selectedValue: selectedName,
              onItemSelected: (person) =>
                  setState(() => selectedName = person.name),
              onItemDeselected: (person) => setState(() => selectedName = null),
            ),*/
            TextField(
              decoration: const InputDecoration(
                hintText: "Text",
              ),
              onChanged: (String text) {
                data.content = text;
              },
            )
          ],
        ),
      ),
    ),
    actions: <Widget>[
      IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.pink.shade100)
        ),
        onPressed: () {
          Database.addData(data);
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.add),
      ),
    ],
  );
}