import 'package:flutter/material.dart';
import 'package:flutter_basic_training/db_models/note.dart';
import 'package:flutter_basic_training/ui_screens/note_details.dart';
import 'package:flutter_basic_training/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NotesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesListSate();
}

class _NotesListSate extends State<NotesList> {

  var _count = 0;
  List<Note> _noteList;
  var _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if(_noteList == null) {
      _noteList = List<Note>();
      updateNoteList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Notes',
          style: TextStyle(
            fontFamily: 'Sans',
            fontWeight: FontWeight.w700
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _count,
          itemBuilder: (context, position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getNoteColor(_noteList[position].priority),
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                _noteList[position].title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w700
                ),
              ),
              subtitle: Text(
                _noteList[position].date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w400
                ),
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.grey),
                onTap: () => _deleteNote(context, _noteList[position].id),
              ),
              onTap: () => _navigateToDetails(this._noteList[position], 'Edit note'),
            ),
          );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add note',
        onPressed: () => _navigateToDetails(Note('', '', 2), 'Add note'),
      ),
    );
  }

  void _navigateToDetails(Note note, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NoteDetails(note, title);
      }
    ));

    if(result) {
      updateNoteList();
    }
  }

  void _deleteNote(BuildContext context, int noteId) async{
    var result = await _databaseHelper.deleteNote(noteId);
    if(result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
      updateNoteList();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: 
        Text(message,
          style: TextStyle(
            fontFamily: 'Sans',
            fontWeight: FontWeight.w700
          ),
        )
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Color getNoteColor(int priority) {
    switch(priority) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  void updateNoteList() {
    final Future<Database> futureDB = _databaseHelper.initializeDatabase();
    futureDB.then((database) {
      Future<List<Note>> futureNoteList = _databaseHelper.getNoteList();
      futureNoteList.then((noteList) {
        setState(() {
          this._noteList = noteList;
          this._count = noteList.length;
        });
      });
    });
  }
}