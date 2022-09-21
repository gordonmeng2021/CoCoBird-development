import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

class SavingOrangeGame extends StatefulWidget {
  const SavingOrangeGame({Key? key}) : super(key: key);

  @override
  _SavingOrangeGameState createState() => _SavingOrangeGameState();
}

class _SavingOrangeGameState extends State<SavingOrangeGame>
    with TickerProviderStateMixin {
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
  GlobalKey _keyOrange = GlobalKey();
  GlobalKey _keyApple = GlobalKey();
  GlobalKey _keyOrange1 = GlobalKey();
  int score = 0;

  CameraController? _cameraController;
  late List<CameraDescription> _camera;
  late CameraDescription _cameraDescription;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);
  late final AnimationController _fastcontroller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  )..repeat(reverse: false);
  late final AnimationController _delaycontroller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<Offset> _orangeAnimation =
      Tween<Offset>(begin: Offset(1, 1), end: Offset(1, 11))
          .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  late final Animation<Offset> _appleAnimation =
      Tween<Offset>(begin: Offset(3, 1), end: Offset(3, 11)).animate(
          CurvedAnimation(parent: _fastcontroller, curve: Curves.slowMiddle));
  late final Animation<Offset> _orange1Animation =
      Tween<Offset>(begin: Offset(5, 1), end: Offset(5, 11)).animate(
          CurvedAnimation(parent: _fastcontroller, curve: Curves.decelerate));

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
                setState(() {
                  _imageStreamToggle();
                });

                Navigator.pushNamed(context, '/');
              },
              child: Container(
                height: 40,
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const Text(
                    ' Next!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
    final RenderBox renderBox =
        _keyOrange.currentContext!.findRenderObject() as RenderBox;
    final positionMonster = renderBox.localToGlobal(Offset.zero);

    var translation = renderBox.getTransformTo(null).getTranslation();
    Size size = MediaQuery.of(context).size;

    if (((faces[0].boundingBox.top - translation.y) < size.width * 0.15 &&
            (faces[0].boundingBox.left - translation.x) < size.width * 0.15) &&
        ((translation.x - faces[0].boundingBox.left) < size.width * 0.15 &&
            (translation.y - faces[0].boundingBox.top) < size.width * 0.15)) {
      setState(() {
        score++;
        print(score);
      });
    }
  }

  void getposition() {
    final RenderBox renderBox =
        _keyOrange.currentContext!.findRenderObject() as RenderBox;
    final positionMonster = renderBox.localToGlobal(Offset.zero);

    var translation = renderBox.getTransformTo(null).getTranslation();
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
                            "Can you save the\noranges by your",
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
          SlideTransition(
            position: _orangeAnimation,
            child: Container(
                key: _keyOrange,
                height: size.width * 0.17,
                width: size.width * 0.17,
                child: Image.asset('assets/images/orange.png')),
          ),
          SlideTransition(
            position: _appleAnimation,
            child: Container(
                key: _keyApple,
                height: size.width * 0.17,
                width: size.width * 0.17,
                child: Image.asset('assets/images/apple.png')),
          ),
          SlideTransition(
            position: _orange1Animation,
            child: Container(
                key: _keyOrange1,
                height: size.width * 0.17,
                width: size.width * 0.17,
                child: Image.asset('assets/images/orange.png')),
          ),

          (_cameraController != null && faces.isNotEmpty)
              ? Positioned(
                  top: faces[0].boundingBox.top - 25,
                  left: faces[0].boundingBox.left - 50,
                  child: Stack(children: [
                    Container(
                        height: size.width * 0.2,
                        width: size.width * 0.2,
                        child: Image.asset('assets/images/frame.png')),
                    Center(
                      child: Container(
                          height: size.width * 0.2,
                          width: size.width * 0.2,
                          child: Image.asset('assets/images/open-hands.png')),
                    ),
                  ]))
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
      getposition();
      //print(faces[0].boundingBox);
      checkAnswer(context);
      setState(() {});
    } else {
      // print('No face detected');
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
