import 'package:flutter/cupertino.dart';
import 'package:todo_db_provider_cohort_11_12/db_helper.dart';

class TodoProvider extends ChangeNotifier {
  DbHelper dbHelper;

  TodoProvider({required this.dbHelper});

  List<Map<String, dynamic>> _mTodo = [];

  List<Map<String, dynamic>> getValue() => _mTodo;

  addTodo({required String title, required String desc}) async {
    bool isAdded = await dbHelper.insertTodo(
        title: title,
        desc: desc);
    if (isAdded) {
      _mTodo = await dbHelper.fetchAllTodo();
      notifyListeners();
    }
  }

  fetchTodo() async {
    _mTodo = await dbHelper.fetchAllTodo();
    notifyListeners();
  }

  toggleTodo({required bool status, required int id}) async {
    bool isUpdated = await dbHelper.updateTodoStatus(status: status, id: id);
    if(isUpdated){
      _mTodo = await dbHelper.fetchAllTodo();
      notifyListeners();
    }
  }
}
