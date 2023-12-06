import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar(
      {required this.searchField, required this.onSearchChanged, super.key});

  final String searchField;
  final ValueChanged<String> onSearchChanged;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      actions: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 40,
              child: SearchBar(
                leading: const Icon(Icons.search),
                onSubmitted: (String value) async {
                  widget.onSearchChanged(value);
                },
              ),
            ),
          ),
        ),
        IconButton(onPressed: () => {
          widget.onSearchChanged("Geolocation")
        }, icon: const Icon(Icons.map))
      ],
    );
  }
}
