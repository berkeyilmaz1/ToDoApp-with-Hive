import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/ProjectConstants/ProjectColors.dart';
import 'package:to_do_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("mybox");
  ToDoDatabase db = ToDoDatabase();

  TextEditingController? taskController = TextEditingController();
  String taskText = "";

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void addNewTask(String task) {
    setState(() {
      db.toDoList.add({'task': task, 'checked': false});
    });
    db.updateDatabase();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index]['checked'] = value;
    });
    db.updateDatabase();
  }

  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    String appName = "To-Do";
    const String saveText = "Kaydet";
    const String cancelText = "İptal";
    const String addNewTaskLabel = "Yeni Görev Ekle";
    String hintText = "Buraya giriniz...";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: const TextStyle(fontSize: 26, letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: ProjectColors.yellow,
                title: const Text(
                  addNewTaskLabel,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                content: TextField(
                  controller: taskController,
                  decoration: InputDecoration(hintText: hintText),
                ),
                actions: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ProjectColors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                        taskController!.clear();
                      },
                      child: const Text(
                        cancelText,
                        style: TextStyle(color: ProjectColors.black),
                      )),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ProjectColors.white)),
                      onPressed: () async {
                        addNewTask(taskController!.text);
                        taskController!.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        saveText,
                        style: TextStyle(color: ProjectColors.black),
                      )),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: ProjectColors.yellow,
                    child: ListTile(
                      title: Text(
                        db.toDoList[index]['task'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: db.toDoList[index]['checked']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () => deleteTask(index),
                          icon: const Icon(
                            Icons.delete,
                            color: ProjectColors.black,
                          )),
                      leading: Checkbox(
                        value: db.toDoList[index]['checked'],
                        onChanged: (value) => checkBoxChanged(value, index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
