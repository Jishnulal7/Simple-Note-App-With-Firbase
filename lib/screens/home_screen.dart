import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task/screens/camera_screen.dart';
import 'package:firebase_task/screens/note_add_screen.dart';
import 'package:firebase_task/screens/note_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool float = false;
  PageController _pagecontroller = PageController();

  final isdialOpen = ValueNotifier(false);

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('To-do').snapshots();
  @override
  void initState() {
    super.initState();
    _pagecontroller = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1,
    );
  }

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
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>  const SignInScreen(),
          //         ));
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          backgroundColor: Colors.deepPurple,
          title: const Text('Note App'),
          centerTitle: true,
        ),
        body: PageView(
          controller: _pagecontroller,
          children: [
            FirstPage(
              stream: _stream,
            ),
            const CameraScreen()
          ],
        ),
        floatingActionButton: FloatingButton(isdialOpen: isdialOpen),
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.isdialOpen,
  });

  final ValueNotifier<bool> isdialOpen;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
                builder: (context) => const NoteAddScreen(),
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
        ),
      ],
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
    required Stream<QuerySnapshot<Object?>> stream,
  }) : _stream = stream;

  final Stream<QuerySnapshot<Object?>> _stream;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                    Map<String, dynamic> document = snapshot.data?.docs[index]
                        .data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteViewScreen(
                              document: document,
                              id: snapshot.data!.docs[index].id,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.deepPurple,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),const SizedBox(height: 25,),
                                Text(
                                  document['description'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            // subtitle: Text(
                            //   document['description'],
                            //   style: const TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 20,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
