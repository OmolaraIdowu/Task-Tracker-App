import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
  });

  final Map<String, dynamic> task;
  final ValueChanged<bool> onCheckboxChanged;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task['isCompleted'];
  }

  void _handleCheckboxChanged(bool newValue) {
    setState(() {
      isChecked = newValue;
      widget.onCheckboxChanged(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey[200]!, spreadRadius: 2, blurRadius: 1),
        ],
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _handleCheckboxChanged(!isChecked);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked ? const Color(0xFF005CE7) : Colors.white,
                border: isChecked
                    ? null
                    : Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
              ),
              child: isChecked
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task['taskTitle'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Lato',
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.task['taskDescription'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
