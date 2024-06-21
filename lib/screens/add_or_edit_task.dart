import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key, this.task});

  final Map<String, dynamic>? task;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!['taskTitle'];
      _descriptionController.text = widget.task!['taskDescription'];
    }
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
      appBar: AppBar(
        title: Text(
          widget.task != null ? 'Edit Task' : 'Create Task',
          style: const TextStyle(
              fontFamily: 'Lato', fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Image.asset('assets/arrow.png', height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8.0),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Type here...',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                      color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Task Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8.0),

              Expanded(
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 1000,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Type here...',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Lato',
                        color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Get data from the form
                        final newTitle = _titleController.text;
                        final newDescription = _descriptionController.text;

                        if (widget.task != null) {
                          // Edit existing task
                          final taskId =
                              widget.task!['id']; // Get taskId from the map
                          // Send data back to HomeScreen
                          Navigator.pop(
                              context, [taskId, newTitle, newDescription]);
                        } else {
                          // Add a new task
                          // Send data back to HomeScreen
                          Navigator.pop(context, [newTitle, newDescription]);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005CE7),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Text(
                      widget.task != null ? 'Apply Changes' : 'Add Task',
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
