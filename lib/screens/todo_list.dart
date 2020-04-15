import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/screens/todo_detail.dart';
import 'package:todo_app/util/dbhelper.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.navigateToDetail(Todo('', 3, ''));
        },
        tooltip: "Add new todo",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.todos[position].priority),
              child: Text(this.todos[position].priority.toString()),
            ),
            title: Text(
              this.todos[position].title,
            ),
            subtitle: Text(
              this.todos[position].date,
            ),
            onTap: () {
              debugPrint("Tapped on ${this.todos[position].id.toString()}");
              navigateToDetail(this.todos[position]);
            },
          ),
        );
      },
    );
  }

  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final todosFuture = helper.getTodos();
      todosFuture.then((list) {
        List<Todo> todoList = List<Todo>();
        count = list.length;
        for (int i = 0; i < count; i++) {
          todoList.add(Todo.fromObject(list[i]));
          debugPrint(todoList[i].title);
        }
        setState(() {
          todos = todoList;
          count = count;
        });
        debugPrint("Item $count");
      });
    });
  }

  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.green;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Todo todo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoDetail(todo),
      ),
    );
    getData();
  }
}
