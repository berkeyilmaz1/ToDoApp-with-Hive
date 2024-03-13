import 'package:hive/hive.dart';

class ToDoDatabase {
  final _mybox = Hive.box("mybox");

  List toDoList = [];

  void createInitialData() {
    List<Map<String, dynamic>> toDoList = [
      {'task': 'Yeni Görevlerinizi Ekleyin!', 'checked': false},
    ];
  }

  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
