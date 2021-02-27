import 'dart:io';
import 'package:flutter_basic_training/db_models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _dataBaseHelper;
  static Database _database;

  var noteTable = 'note_table';
  var colId = 'id';
  var colTitle = 'title';
  var colDesc = 'description';
  var colDate = 'date';
  var colPriority = 'priority';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DatabaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = directory.path + 'notes.db';
    var database = openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDesc TEXT, $colDate TEXT, $colPriority INTEGER)');
  }

  //Fetch notes
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    var db = await database;
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  //Insert note
  Future<int> insertNote(Note note) async {
    var db = await database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //Update note
  Future<int> updateNote(Note note) async {
    var db = await database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //Delete note
  Future<int> deleteNote(int id) async {
    var db = await database;
    var result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //Total notes
  Future<int> getCount() async {
    var db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $noteTable');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMap = await getNoteMapList();
    List<Note> noteList = List<Note>();
    for (int i = 0; i < noteMap.length; i++) {
      noteList.add(Note.fromMapObject(noteMap[i]));
    }
    return noteList;
  }
}
