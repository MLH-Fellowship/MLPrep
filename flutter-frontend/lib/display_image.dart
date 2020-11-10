import 'package:CookMe/ingredients.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:tflite/tflite.dart';

class DisplayImage extends StatefulWidget {
  final String imagePath;

  DisplayImage({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  File image;
  List _recognitions;
  List _ingredients;
  bool _busy;
  double _imageWidth, _imageHeight;

  @override
  void initState() {
    super.initState();
    _busy = true;
    rotateImage().then((val) {
      {
        loadTfModel().then((val) {
          {
            detectObject(image).then((val) {
              {
                setState(() {
                  _busy = false;
                });
              }
            });
          }
        });
      }
    });
  }

  rotateImage() async {
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: widget.imagePath);
    setState(() {
      image = rotatedImage;
    });
  }

  // Loads the tflite model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels_ssd.txt",
    );
  }

  // Detects objects in image
  detectObject(File image) async {
    List recognitions = await Tflite.detectObjectOnImage(
        path: image.path, // required
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4, // defaults to 0.1
        numResultsPerClass: 10, // defaults to 5
        asynch: true // defaults to true
        );

    // Get the object name and filter duplicates
    List<String> ingredients = recognitions
        .map((re) {
          return re['detectedClass'].toString();
        })
        .toSet()
        .toList();

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));

    setState(() {
      _recognitions = recognitions;
      _ingredients = ingredients;
    });
  }

  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    return _recognitions.map((re) {
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                    child: Text(
                      "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        background: Paint()..color = Colors.blue,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                : Container()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      child: Container(child: Image.file(image)),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Display the Image')),
      body: Container(
        child: Stack(
          children: stackChildren,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: Icon(Icons.delete_forever),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                if (_ingredients != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              IngredientsList(ingredients: _ingredients)));
                }
              },
              child: Icon(Icons.done),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
