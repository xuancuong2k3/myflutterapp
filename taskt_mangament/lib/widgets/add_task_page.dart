import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskt_mangament/models/task.dart';

class AddTaskPage extends StatefulWidget {
  final Function(Task) addTaskCallback;

  AddTaskPage({required this.addTaskCallback});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1C),
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Due Date',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              readOnly: true,
              controller: _dateController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    pickedDate = pickedDate.add(Duration(
                      hours: pickedTime.hour,
                      minutes: pickedTime.minute,
                    ));
                    setState(() {
                      _selectedDate = pickedDate!;
                      _dateController.text = DateFormat.yMd().add_Hm().format(pickedDate);
                    });
                  }
                }
              },
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text.trim();
                final String description = _descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final Task newTask = Task(
                    title: title,
                    description: description,
                    dateTime: _selectedDate,
                  );
                  widget.addTaskCallback(newTask);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Task',
                style: TextStyle(color: Color(0xFF5C699F)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3B3B3B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
