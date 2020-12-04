import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _taskName;
  String _taskDescription;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = 'tasks.json';
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String filename) {
    File file = new File(dir.path + "/" + filename);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new task'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0),
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _showNameTextbox(context),
              _showDescriptionTextbox(context),
              _saveTaskButton(context)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _showNameTextbox(BuildContext _context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      height: MediaQuery.of(_context).size.height * 0.10,
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: "Task name",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _showDescriptionTextbox(BuildContext _context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      height: MediaQuery.of(_context).size.height * 0.3,
      child: TextField(
        controller: _descriptionController,
        decoration: InputDecoration(
          hintText: "Task description",
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
      ),
    );
  }

  Widget _saveTaskButton(BuildContext _context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      height: MediaQuery.of(_context).size.height * 0.10,
      child: RaisedButton(
        onPressed: () {
          _saveNewTask();
        },
        color: Colors.blue,
        child: Text(
          'Save task',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }

  void _saveNewTask() {
    _taskName = _nameController.text;
    _taskDescription = _descriptionController.text;
    print(dir);
    print(fileExists);
    print(fileContent);
    writeToFile(_taskName, _taskDescription);
    print(fileContent);
  }
}
