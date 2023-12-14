import 'package:flutter/material.dart';
import 'package:module_04/utils/data_model.dart';
import 'package:module_04/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_04/utils/feelings.dart';
import 'package:selectable_list/selectable_list.dart';

class AddPopUp extends StatefulWidget {
  AddPopUp({super.key});

  MapEntry<String, Icon> selectedFeeling = const MapEntry("", Icon(Icons.error));
  String title = "";
  String content = "";

  @override
  State<AddPopUp> createState() => _AddPopUpState();
}

class _AddPopUpState extends State<AddPopUp> {
  @override
  Widget build(BuildContext context) {

    DataModel data = DataModel(DateTime.now(), FirebaseAuth.instance.currentUser!.email, "", "", "", "");


    void setSelectedFeeling(MapEntry<String, Icon> feel) {
      setState(() {
        widget.selectedFeeling = feel;
      });
    }
    
    void setTitle(String text) {
      setState(() {
        widget.title = text;
      });
    }

    void setContent(String text) {
      setState(() {
        widget.content = text;
      });
    }

    return AlertDialog(
      title: const Text('Add new entry'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                  onChanged: (String text) {
                    setTitle(text);
                  },
                  maxLength: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Feelings.feelings.entries.map(
                            (e) => IconButton(
                                onPressed: () {
                                  setSelectedFeeling(e);
                                },
                                icon: e.value,
                              style: ButtonStyle(
                                backgroundColor: (widget.selectedFeeling.key == e.key ? const MaterialStatePropertyAll(Colors.blueGrey) : const MaterialStatePropertyAll(Colors.transparent))
                              ),
                            )
                    ).toList(),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Text",
                  ),
                  onChanged: (String text) {
                    setContent(text);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.pink.shade100)
          ),
          onPressed: () {
            data.feeling = widget.selectedFeeling.key;
            data.title = widget.title;
            data.content = widget.content;
            if (data.feeling == "" || data.title == "" || data.content == "") {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text("You must enter a title, a feeling and a content"),
                  );
                },
              );
            }
            else {
              Database.addData(data);
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}


