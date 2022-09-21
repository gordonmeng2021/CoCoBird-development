import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

class CameraGame extends StatefulWidget {
  @override
  _CameraGameState createState() => _CameraGameState();
}

class _CameraGameState extends State<CameraGame> {
  final dref = FirebaseDatabase.instance
      .refFromURL('https://cameratest-39e72-default-rtdb.firebaseio.com/');

  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  CustomPaint? customPaint;
  bool _isRun = false;
  bool _predicting = false;
  bool _draw = false;
  List<Face> faces = [];
  List<Widget>? computer;
  int count = 0;
  int countdown = 0;

  CameraController? _cameraController;
  late List<CameraDescription> _camera;
  late CameraDescription _cameraDescription;

  void initState() {
    super.initState();
    initCamera();
  }

  Future showSimpleDialog() => showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              'Great job!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
            ),
            content: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
              onPressed: () {
                Navigator.pushNamed(context, '/huntingGame');
              },
              child: Container(
                height: 20,
                width: 70,
                child: const Text(
                  '  Next!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ));
  Future showTimeOutDialog() => showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              'Time Out!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
            ),
            content: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  onPressed: () {
                    setState(() {
                      _imageStreamToggle();
                    });

                    Navigator.pushNamed(context, '/cameraGame');
                  },
                  child: Container(
                    height: 40,
                    width: 70,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        ' Again',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                    onPressed: () {
                      setState(() {
                        _imageStreamToggle();
                      });

                      Navigator.pushNamed(context, '/huntingGame');
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          ' Next',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));

  initCamera() async {
    _camera = await availableCameras();
    _cameraDescription = _camera[1];
    _onNewCameraSelected(_cameraDescription);
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _cameraController!.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController!.value.hasError) {
        _showInSnackBar(
            'Camera error ${_cameraController!.value.errorDescription}');
      }
    });

    try {
      await _cameraController!.initialize().then((value) {
        if (!mounted) return;
      });
    } on CameraException catch (e) {
      _showInSnackBar('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  double? getTop(List<Face> faces) {
    return faces[0].boundingBox.top;
  }

  double? getLeft(List<Face> faces) {
    return faces[0].boundingBox.left;
  }

  void _showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void checkAnswer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (faces[0].boundingBox.left <= size.width * 0.2 + size.width * 0.3 &&
        faces[0].boundingBox.left >= size.width * 0.2 &&
        faces[0].boundingBox.top >= size.width * 1.485 &&
        faces[0].boundingBox.top <= (size.width * 1.485 + size.width * 0.3)) {
      count++;

      if (count == 40) {
        _imageStreamToggle();
        showSimpleDialog();
        dref.update({'cameraGame': 'win'});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          (_cameraController != null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Container(
                              child: Text(
                            "Can you match\nthe toys by your",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[100]),
                          )),
                          Text(
                            "HEAD?",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              setState(() {
                                _imageStreamToggle();
                              });
                            },
                            child: const Text(
                              'GO!',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Center(
                        child: Container(
                            height: 650,
                            width: 400,
                            child: CameraPreview(_cameraController!))),
                  ],
                )
              : Container(
                  child: Text("no face"),
                ),

          //answer
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 1.485, left: size.width * 0.2),
            child: Container(
              height: size.width * 0.4,
              width: size.width * 0.4,
              // color: Colors.yellow,
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Stack(children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          toyBuild(context, 'assets/images/t-doll.png'),
                          toyBuild(context, 'assets/images/toy-blocks.png'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        toyBuild(context, 'assets/images/t-dragon.png'),
                        toyBuild(context, 'assets/images/toy.png')
                      ],
                    ),
                  ]),
                  Center(
                    child: Container(
                        height: 170,
                        width: 170,
                        child: Image.asset('assets/images/frame.png')),
                  )
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/t-doll.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/t-doll.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/t-doll.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/t-doll.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/t-doll.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/t-doll.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  toyBuild(context, 'assets/images/t-doll.png'),
                  toyBuild(context, 'assets/images/t-dragon.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                  toyBuild(context, 'assets/images/toy-blocks.png'),
                  toyBuild(context, 'assets/images/toy.png'),
                ],
              ),
            ],
          ),
          (_cameraController != null && faces.isNotEmpty)
              ? Positioned(
                  top: faces[0].boundingBox.top - 25,
                  left: faces[0].boundingBox.left - 50,
                  child: Container(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/frame.png')))
              : Container()
        ],
      )),
    );
  }

  Widget toyBuild(BuildContext context, String path) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.width * 0.01),
      child: Container(
          //height: size.height * 0.12,
          width: size.width * 0.17,
          child: Image.asset(
            path,
            fit: BoxFit.fitWidth,
          )),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    faces = await faceDetector.processImage(inputImage);
    setState(() {});

    // print(faces[0].)
    if (faces.length > 0) {
      countdown++;
      // print(countdown);
      if (countdown == 750) {
        showTimeOutDialog();
      }

      //print(faces[0].boundingBox);
      checkAnswer(context);
      setState(() {});
    } else {
      print('No face detected');
    }

    //print('Found ${faces.length} faces');
    isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }

  void _imageStreamToggle() {
    setState(() {
      _draw = !_draw;
    });

    _isRun = !_isRun;
    if (_isRun) {
      _cameraController!.startImageStream((CameraImage cameraImage) async {
        InputImage inputImage = await processCameraImage(cameraImage, _camera);
        processImage(inputImage);
      });
    } else {
      _cameraController!.stopImageStream();
    }
  }

  Future<InputImage> processCameraImage(
      CameraImage image, List<CameraDescription>? cameras) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras![1];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    return inputImage;
  }
}
