import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider_cohort_11_12/db_helper.dart';
import 'package:todo_db_provider_cohort_11_12/todo_provider.dart';

import 'home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoProvider(
          dbHelper: DbHelper.getInstance()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

