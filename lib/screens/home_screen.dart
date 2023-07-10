import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task/screens/camera_screen.dart';
import 'package:firebase_task/screens/content_screen.dart';
import 'package:firebase_task/screens/todo_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isdialOpen = ValueNotifier(false);
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('To-do').snapshots();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isdialOpen.value) {
          isdialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('To-do App'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> document =
                            snapshot.data?.docs[index].data()
                                as Map<String, dynamic>;
                        return TodoCard(document: document);
                      },
                    );
                  })
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          closeDialOnPop: true,
          overlayOpacity: .5,
          spaceBetweenChildren: 15,
          overlayColor: Colors.transparent,
          openCloseDial: isdialOpen,
          backgroundColor: Colors.white,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.note_add,
                color: Colors.deepPurple,
              ),
              label: 'Add new',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentScreen(),
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.camera_alt,
                color: Colors.deepPurple,
              ),
              label: 'Camera',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
