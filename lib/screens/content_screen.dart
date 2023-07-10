// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurple,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurple,
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  maxLines: 15,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    hintText: 'Start typing',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      FirebaseFirestore.instance.collection("To-do").add({
                        'title': _titleController.text,
                        'description': _descriptionController.text
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {},
                    child: const Text('Cancel'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
