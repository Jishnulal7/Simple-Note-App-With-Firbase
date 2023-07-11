import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteViewScreen extends StatefulWidget {
  const NoteViewScreen({super.key, required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;
  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  bool edit = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // String title = widget.document['title'] ?? 'Hello';
    _titleController = TextEditingController(
      text: widget.document['title'],
    );
    _descriptionController = TextEditingController(
      text: widget.document['description'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          edit ? 'Edit Note' : 'View Note',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  edit = !edit;
                });
              },
              child: Icon(
                Icons.edit,
                color: edit ? Colors.red : Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurple,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  enabled: edit,
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
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.deepPurple,
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  enabled: edit,
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  maxLines: 15,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    hintText: 'Start typing..........',
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
                      FirebaseFirestore.instance
                          .collection("To-do")
                          .doc(widget.id)
                          .update(
                        {
                          'title': _titleController.text,
                          'description': _descriptionController.text
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
