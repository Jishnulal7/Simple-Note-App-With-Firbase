
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key,});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await cameraController?.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      // Handle camera initialization error
      print('Failed to initialize camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController?.value.isInitialized ?? false) {
      return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: SizedBox(
                height: 500,
                width: 300,
                child: CameraPreview(cameraController!),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    cameraController!.takePicture().then(
                      (XFile? file) {
                        if (mounted) {
                          if (file != null) {
                            print('Picture saved to ${file.path}');
                          }
                        }
                      },
                    );
                  },
                  child: const Icon(
                    Icons.done,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.close,
                    size: 50,
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
