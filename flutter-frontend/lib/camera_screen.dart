import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'display_image.dart';
import 'package:CookMe/ingredients.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key key, @required this.camera}) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController controller;
  Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Create a CameraController to display the current output from the camera
    controller = CameraController(widget.camera, ResolutionPreset.medium);

    // Initialize the controller. This returns a Future.
    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    // Dispose the controller whenthe widget is disposed
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngredientsList(
                              ingredients: <String>["apples", "pears"])));
                } catch (e) {
                  // Log error to the console
                  print(e);
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
