import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/pages/home_page.dart';

import '../ProjectConstants/ProjectColors.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        checkboxTheme: const CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(ProjectColors.black),
          fillColor: MaterialStatePropertyAll(ProjectColors.yellow),
        ),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black))),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ProjectColors.yellow, splashColor: Colors.white54),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.yellow))),
        appBarTheme: const AppBarTheme(
          backgroundColor: ProjectColors.yellow,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
