// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key,});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late List<CameraDescription> cameras;
//   CameraController? cameraController;

//   @override
//   void initState() {
//     startCamera();
//     super.initState();
//   }

//   startCamera() async {
//     cameras = await availableCameras();

//     cameraController = CameraController(
//       cameras[0],
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     try {
//       await cameraController?.initialize();
//       if (mounted) {
//         setState(() {});
//       }
//     } catch (e) {
//       // Handle camera initialization error
//       print('Failed to initialize camera: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (cameraController?.value.isInitialized ?? false) {
//       return Scaffold(
//         body: Column(
//           children: [
//             const SizedBox(
//               height: 100,
//             ),
//             Center(
//               child: SizedBox(
//                 height: 500,
//                 width: 300,
//                 child: CameraPreview(cameraController!),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     cameraController!.takePicture().then(
//                       (XFile? file) {
//                         if (mounted) {
//                           if (file != null) {
//                             print('Picture saved to ${file.path}');
//                           }
//                         }
//                       },
//                     );
//                   },
//                   child: const Icon(
//                     Icons.done,
//                     size: 50,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 70,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: const Icon(
//                     Icons.close,
//                     size: 50,
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(imageFile != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover),
                  color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Image should appear here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
            else
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: FileImage(imageFile!)),
                  color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Image should appear here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        getImage(source: ImageSource.camera);
                      },
                      child: const Text('Capture Image'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        getImage(source: ImageSource.gallery);
                      },
                      child: const Text('Select Image'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
