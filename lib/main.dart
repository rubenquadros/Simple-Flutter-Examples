import 'package:flutter/material.dart';
import 'package:flutter_basic_training/ui_screens/first_screen.dart';
import 'package:flutter_basic_training/ui_screens/interest_calculator.dart';
import 'package:flutter_basic_training/ui_screens/note_details.dart';
import 'package:flutter_basic_training/ui_screens/notes_list.dart';
import 'package:flutter_basic_training/ui_screens/stateful_widget.dart';
import 'package:flutter_basic_training/ui_screens/static_list_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter World',
    home: NotesList(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      fontFamily: 'Sans'
    ),
  ));
}