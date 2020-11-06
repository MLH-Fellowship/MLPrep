import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'display_image.dart';


class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key key, @required this.camera}) : super(key:key);

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
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            // Ensure camera is initialized
            await initializeControllerFuture;

            // Construct path where image is saved
            final path = join(
              // Store picture in temp directory
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Take a picture and log where it's saved
            await controller.takePicture(path);

            // If picture was taken, display image on new screen
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => DisplayImageScreen(imagePath: path)
              )
            );
          } catch (e) {
            // Log error to the console
            print(e);
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}