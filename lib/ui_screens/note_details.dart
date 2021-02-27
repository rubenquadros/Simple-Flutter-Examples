import 'package:flutter/material.dart';
import 'package:flutter_basic_training/db_models/note.dart';
import 'package:flutter_basic_training/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetails extends StatefulWidget {
  final _appBarTitle;
  final _note;

  NoteDetails(this._note, this._appBarTitle);

  @override
  State<StatefulWidget> createState() =>
      _NoteDetailsState(this._note, this._appBarTitle);
}

class _NoteDetailsState extends State<NoteDetails> {
  String _appBarTitle;
  Note _note;

  _NoteDetailsState(this._note, this._appBarTitle);

  var _priorities = ['High', 'Low'];
  var _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  var _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    _titleController.text = _note.title;
    _descController.text = _note.description;

    return WillPopScope(
        onWillPop: () async {
          _moveToNotesScreen();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _appBarTitle,
              style: TextStyle(fontFamily: 'Sans', fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _moveToNotesScreen(),
            ),
          ),
          body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: DropdownButton(
                        items: _priorities
                            .map((value) =>
                            DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'Sans',
                                    fontWeight: FontWeight.w400),
                              ),
                            ))
                            .toList(),
                        value: _getPriorityAsString(_note.priority),
                        onChanged: (input) => _onPriorityChanged(input),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _titleController,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Please provide a title',
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontFamily: 'Sans',
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _descController,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Please provide a description',
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontFamily: 'Sans',
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              textColor: Theme
                                  .of(context)
                                  .primaryColorLight,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Sans',
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                setState(() {
                                  _saveNote();
                                });
                              },
                            )),
                        Container(width: 50.0),
                        Expanded(
                            child: RaisedButton(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              textColor: Theme
                                  .of(context)
                                  .primaryColorLight,
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Sans',
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                setState(() {
                                  _deleteNote();
                                });
                              },
                            ))
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  void _onPriorityChanged(String input) {
    setState(() {
      _updatePriorityAsInt(input);
    });
  }

  void _updatePriorityAsInt(String priority) {
    switch (priority) {
      case 'High':
        _note.priority = 2;
        break;
      case 'Low':
        _note.priority = 1;
        break;
      default:
        _note.priority = 1;
    }
  }

  String _getPriorityAsString(int priority) {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'High';
      default:
        return 'Low';
    }
  }

  void _saveNote() async {
    if (_formKey.currentState.validate()) {
      _moveToNotesScreen();
      _note.title = _titleController.text;
      _note.description = _descController.text;
      _note.date = DateFormat.yMMMd().format(DateTime.now());
      int result;
      if (_note.id == null) {
        //insert
        result = await _dbHelper.insertNote(_note);
      } else {
        //update
        result = await _dbHelper.updateNote(_note);
      }
      if (result != 0) {
        _showDialog('Status', 'Note saved successfully');
      } else {
        _showDialog('Status', 'Note could not be saved');
      }
    }
  }

  void _deleteNote() async {
    if (_note.id != null) {
      _moveToNotesScreen();
      int result = await _dbHelper.deleteNote(_note.id);
      if (result != 0) {
        _showDialog('Status', 'Note deleted successfully');
      } else {
        _showDialog('Status', 'Note could not be deleted');
      }
    }
  }

  void _showDialog(String title, String message) {
    var alertDialog = AlertDialog(
        titlePadding: EdgeInsets.all(10.0),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w700),
        ),
        contentPadding: EdgeInsets.all(20.0),
        content: Text(
          message,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w400),
        ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _moveToNotesScreen() {
    Navigator.pop(context, true);
  }
}
