import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Feelings {

  static Map<String, Icon> feelings = {
    "Happy": const Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 50),
    "Satisfied": const Icon(Icons.sentiment_satisfied, color: Colors.greenAccent, size: 50),
    "Neutral": const Icon(Icons.sentiment_neutral, color: Colors.yellow, size: 50),
    "Sad": const Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent, size: 50),
    "Very sad": const Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 50),
  };

  static Icon getIcon(String feel) {
    Icon res = feelings[feel] ?? const Icon(Icons.error, color: Colors.red,);
    return res;
  }
}