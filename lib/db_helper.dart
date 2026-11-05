import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  static String db_name = "todoDB.db";
  static String table_todo = "todos";

  static String column_todo_id = "t_id";
  static String column_todo_title = "t_title";
  static String column_todo_desc = "t_desc";
  static String column_todo_created_at = "t_created_at";
  static String column_todo_is_completed = "t_is_completed";

  /// 1 for true and 0 for false

  Database? mDB;

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, db_name);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table $table_todo ( $column_todo_id integer primary key autoincrement, $column_todo_title text, $column_todo_desc text, $column_todo_created_at text, $column_todo_is_completed integer)",
        );
      },
    );
  }

  Future<bool> insertTodo({required String title, required String desc}) async {
    var db = await initDB();

    int rowsEffected = await db.insert(table_todo, {
      column_todo_title: title,
      column_todo_desc: desc,
      column_todo_created_at: DateTime.now().millisecondsSinceEpoch.toString(),
      column_todo_is_completed: 0,
    });

    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> fetchAllTodo() async {
    var db = await initDB();
    return await db.query(table_todo);
  }

  Future<bool> updateTodoStatus({required bool status, required int id}) async {
    var db = await initDB();

    int rowsEffected = await db.update(
      table_todo,
      {column_todo_is_completed: status ? 1 : 0},
      where: "$column_todo_id = ?",
      whereArgs: ["$id"],
    );
    return rowsEffected>0;
  }
}
