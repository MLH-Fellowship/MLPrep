import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_screen.dart';

CameraDescription rearCamera;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  rearCamera = cameras.first;

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel()..loadRecipes(),
      child: CupertinoStoreApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MLPrep',
        theme: ThemeData.dark(),
        home: CameraScreen(camera: rearCamera));
  }
}
