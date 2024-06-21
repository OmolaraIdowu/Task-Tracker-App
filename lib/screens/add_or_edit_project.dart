import 'package:flutter/material.dart';

class AddEditProjectScreen extends StatefulWidget {
  const AddEditProjectScreen({super.key});

  @override
  State<AddEditProjectScreen> createState() => AddEditProjectScreenState();
}

class AddEditProjectScreenState extends State<AddEditProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Project',
          style: TextStyle(
              fontFamily: 'Lato', fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Image.asset('assets/arrow.png', height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(
        child: Text('You did it!'),
      ),
    );
  }
}
