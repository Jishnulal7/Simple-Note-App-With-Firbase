import 'package:firebase_task/screens/camera_screen.dart';
import 'package:firebase_task/screens/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isdialOpen = ValueNotifier(false);
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
              ListView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
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
