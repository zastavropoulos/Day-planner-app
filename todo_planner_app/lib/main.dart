import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_planner_app/screens/addTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do planner app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Day planner app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTask()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 30.0, 0, 0),
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('files/tasks.json'),
          builder: (context, snapshot) {
            var tasksData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemCount: (tasksData == null) ? 0 : tasksData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${tasksData[index]['name']}'),
                      Icon(Icons.check_circle_outline),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
