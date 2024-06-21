import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/screens/add_or_edit_project.dart';
import 'package:task_tracker/screens/add_or_edit_task.dart';
import 'package:task_tracker/screens/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
  int _selectedTab = 0;
  bool _showFabs = false;

  List<Map<String, dynamic>> tasks = [
    {
      'id': 1,
      'taskTitle': 'Task 1',
      'taskDescription': 'Description 1',
      'isCompleted': false,
    },
    {
      'id': 2,
      'taskTitle': 'Task 2',
      'taskDescription': 'Description 2',
      'isCompleted': false,
    },
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _toggleFabButtons() {
    setState(() {
      _showFabs = !_showFabs;
    });
  }

  void _addTask(String title, String description) {
    setState(() {
      int nextId = tasks.isNotEmpty ? tasks.last['id']! + 1 : 1;
      tasks.add({
        'id': nextId,
        'taskTitle': title,
        'taskDescription': description,
        'isCompleted': false,
      });
    });
  }

  void _editTask(int taskId, String newTitle, String newDescription) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task['id'] == taskId);
      if (taskIndex != -1) {
        tasks[taskIndex] = {
          'id': taskId,
          'taskTitle': newTitle,
          'taskDescription': newDescription,
          'isCompleted': tasks[taskIndex]['isCompleted'],
        };
      }
    });
  }

  void _deleteTask(int taskId) {
    setState(() {
      tasks.removeWhere((task) => task['id'] == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            children: [
              _buildTopContainer(),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCard(
                      'assets/new.png',
                      'Total Tasks',
                      '${tasks.length}',
                    ),
                    const SizedBox(width: 24.0),
                    buildCard(
                      'assets/done.png',
                      'Completed Tasks',
                      '${tasks.where((task) => task['isCompleted']).length}',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF005CE7),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Task of the day',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: tasks.isEmpty
                      ? const Center(
                          child: Text(
                            'No tasks available',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lato',
                              color: Colors.black,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(tasks[index]['id'].toString()),
                              onDismissed: (direction) {
                                final deletedTask = tasks[index];
                                _deleteTask(tasks[index]['id']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Task "${deletedTask['taskTitle']}" deleted'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        setState(() {
                                          tasks.add(deletedTask);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              background: Container(
                                padding: const EdgeInsets.only(right: 20),
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Edit selected task
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddEditTaskScreen(
                                        task: tasks[index], // Pass task data
                                      ),
                                    ),
                                  ).then((data) {
                                    if (data != null && data is List) {
                                      if (data.length == 3) {
                                        _editTask(data[0], data[1], data[2]);
                                      } else if (data.length == 2) {
                                        // Add new task
                                        _addTask(data[0], data[1]);
                                      }
                                    }
                                  });
                                },
                                child: TaskItem(
                                  task: tasks[index],
                                  onCheckboxChanged: (isChecked) {
                                    setState(() {
                                      tasks[index]['isCompleted'] = isChecked;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
          if (_showFabs)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleFabButtons,
                child: Container(
                  color: Colors.white60,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 90,
                        right: 16,
                        child: Row(
                          children: [
                            const Text(
                              'New Project',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 16),
                            FloatingActionButton(
                              onPressed: () {
                                _toggleFabButtons();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEditProjectScreen(),
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xFF005CE7),
                              shape: const CircleBorder(),
                              child: const ImageIcon(
                                AssetImage('assets/project.png'),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 160,
                        right: 16,
                        child: Row(
                          children: [
                            const Text(
                              'New Task',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 16),
                            FloatingActionButton(
                              onPressed: () {
                                _toggleFabButtons();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddEditTaskScreen(),
                                  ),
                                ).then((data) {
                                  if (data != null && data is List) {
                                    if (data.length == 2) {
                                      _addTask(data[0], data[1]);
                                    } else if (data.length == 3) {
                                      _editTask(data[0], data[1], data[2]);
                                    }
                                  }
                                });
                              },
                              backgroundColor: const Color(0xFF005CE7),
                              shape: const CircleBorder(),
                              child: const ImageIcon(
                                AssetImage('assets/add_task.png'),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _toggleFabButtons,
        backgroundColor: _showFabs ? Colors.white : const Color(0xFF005CE7),
        child: Icon(
          _showFabs ? Icons.close : Icons.add,
          color: _showFabs ? Colors.black : Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: const Color(0xFF005CE7),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontFamily: 'Lato'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Lato'),
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/home.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/project.png'),
            ),
            label: 'Project',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/calendar.png'),
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/menu.png'),
            ),
            label: 'Menu',
          ),
        ],
      ),
    );
  }

  Widget buildCard(String imagePath, String title, String noOfTasks) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, spreadRadius: 2, blurRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              noOfTasks,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContainer() {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEE, MMM d').format(now);

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Hi, ${widget.userName} 👋',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              ImageIcon(
                AssetImage('assets/search.png'),
              ),
              SizedBox(width: 20.0),
              ImageIcon(
                AssetImage('assets/notification.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
