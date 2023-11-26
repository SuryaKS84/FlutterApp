import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter_project/task.dart';
import 'package:flutter_project/taskDetails.dart';
import 'package:flutter_project/taskForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'zDM6cDyKrMviKStfKTbvJjxxmZPgAGHwRg2AH3k6';
  const keyClientKey = 'J1QzX3TxiVW78KHPJN0o9Zo9ob42aUWzTXPrPpF';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.indigo,
          primaryVariant: Colors.indigo[700]!,
          secondary: Colors.pink,
          secondaryVariant: Colors.pink[700]!,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<CustomTask> tasks = [];
  bool isFilter = false;

  @override
  Widget build(BuildContext context) {
    getTasks();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        child: Icon(Icons.add_circle_outline),
      ),
      body: Scaffold(
        bottomSheet: Flex(
          direction: Axis.horizontal,
          children: [
            Checkbox(
              value: isFilter,
              onChanged: (value) {
                setState(() {
                  isFilter = value!;
                });
              },
            ),
            Text("Filter by Undone Tasks")
          ],
        ),
        body: Padding(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              if (isFilter == true && tasks[index].taskStatus != "open") {
                return SizedBox();
              }
              return ListTile(
                title: Text(tasks[index].taskName),
                subtitle: Row(
                  children: [
                    _buildIconButton(
                      tasks[index].taskStatus == "open",
                      Icons.done,
                      "Complete Task",
                      "Are you sure you want to mark this task as done?",
                      () => _doneOrDeleteTask(tasks[index], "done"),
                    ),
                    _buildIconButton(
                      tasks[index].taskStatus == "open",
                      Icons.delete,
                      "Delete Task",
                      "Do you want to delete this task?",
                      () => _doneOrDeleteTask(tasks[index], "delete"),
                    ),
                    _buildIconButton(
                      tasks[index].taskStatus == "open",
                      Icons.edit,
                      "Update Task",
                      "Do you want to update this task?",
                      () => _updateTask(tasks[index]),
                    ),
                  ],
                  textDirection: TextDirection.rtl,
                ),
                onTap: () => _navigateToDetailsTask(context, tasks[index]),
              );
            },
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 70),
        ),
      ),
    );
  }

  Widget _buildIconButton(
    bool condition,
    IconData icon,
    String title,
    String message,
    VoidCallback onPressed,
  ) {
    return condition
        ? IconButton(
            onPressed: () => _checkDialog(title, message, onPressed),
            icon: Icon(icon),
          )
        : Text("");
  }

  void _checkDialog(String title, String message, VoidCallback onConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.cancel_outlined),
              ),
              ElevatedButton(
                onPressed: () {
                  onConfirmed();
                  Navigator.pop(context);
                },
                child: Icon(Icons.done_outline),
              ),
            ],
          ),
        );
      },
    );
  }

  void _doneOrDeleteTask(CustomTask task, String action) {
    if (action == "delete") {
      _deleteTask(task);
    } else if (action == "done") {
      _doneTask(task);
    }
  }

  void _deleteTask(CustomTask task) async {
    var taskObj = ParseObject("Task")..objectId = task.taskId;
    await taskObj.delete().then((value) => getTasks());
  }

  void _doneTask(CustomTask task) {
    var taskObj = ParseObject("Task")..objectId = task.taskId;
    taskObj.set("taskStatus", "done");
    taskObj.update().then((value) => getTasks());
  }

  void _updateTask(CustomTask task) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => TaskForm(isUpdate: true, task: task)))
        .then((value) => getTasks());
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const TaskForm()))
        .then((value) => getTasks());
  }

  void _navigateToDetailsTask(BuildContext context, CustomTask task) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TaskDetailsForm(task)));
  }

  void getTasks() async {
    var taskQuery = QueryBuilder<ParseObject>(ParseObject("Task"))
      ..orderByDescending("taskStatus")
      ..orderByAscending("taskName");
    final taskResponse = await taskQuery.query();
    var taskResults = <CustomTask>[];
    if (taskResponse.success && taskResponse.results != null) {
      taskResults.clear();
      for (var o in taskResponse.results!) {
        var taskMap = o as ParseObject;
        var taskId = taskMap.objectId;
        var taskName = taskMap.get("taskName", defaultValue: "");
        var taskDescription = taskMap.get("taskDescription", defaultValue: "");
        var taskStatus = taskMap.get("taskStatus", defaultValue: "open");
        var taskObj = CustomTask(taskId!, taskName!, taskDescription!, taskStatus!);
        taskResults.add(taskObj);
      }
    }
    setState(() {
      tasks
        ..clear()
        ..addAll(taskResults);
    });
  }
}