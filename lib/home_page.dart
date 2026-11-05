import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider_cohort_11_12/add_todo_page.dart';
import 'package:todo_db_provider_cohort_11_12/db_helper.dart';
import 'package:todo_db_provider_cohort_11_12/todo_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Consumer<TodoProvider>(
        builder: (_, provider, _) {
          var mTodos = provider.getValue();

          return mTodos.isNotEmpty
              ? ListView.builder(
                  itemCount: mTodos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value:
                              mTodos[index][DbHelper
                                  .column_todo_is_completed] ==
                              1,
                          onChanged: (value) {
                            context.read<TodoProvider>().toggleTodo(
                              status: value ?? false,
                              id: mTodos[index][DbHelper.column_todo_id],
                            );
                          },
                        ),
                        title: Text(mTodos[index][DbHelper.column_todo_title],
                          style: TextStyle(
                              decoration: mTodos[index][DbHelper
                                  .column_todo_is_completed] ==
                                  1 ? TextDecoration.lineThrough : TextDecoration.none
                          ),),
                        subtitle: Text(
                          mTodos[index][DbHelper.column_todo_desc],
                          style: TextStyle(
                            decoration: mTodos[index][DbHelper
                                .column_todo_is_completed] ==
                                1 ? TextDecoration.lineThrough : TextDecoration.none
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text("No Todos yet!!"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
