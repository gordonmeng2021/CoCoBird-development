import 'package:coocoobird_design/Mainscreen/lightbluewidgets/build.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mapping_shape extends StatefulWidget {
  const Mapping_shape({Key? key}) : super(key: key);

  @override
  _Mapping_shapeState createState() => _Mapping_shapeState();
}

class _Mapping_shapeState extends State<Mapping_shape> {
  final dref = FirebaseDatabase.instance
      .refFromURL('https://cameratest-39e72-default-rtdb.firebaseio.com/');
  late Map<int, Widget> dragList;
  late Map<int, Widget> targetList;

  @override
  void initState() {
    dragList = {
      1: _draggable(data: 1, path: 'assets/images/new-moon.png'),
      2: _draggable(data: 2, path: 'assets/images/star.png'),
      3: _draggable(data: 3, path: 'assets/images/square (1).png'),
      4: _draggable(data: 4, path: 'assets/images/hexagon_color.png')
    };

    targetList = {
      2: _dragTarget(answer: 2, path: 'assets/images/starblack.png'),
      4: _dragTarget(answer: 4, path: 'assets/images/hexagon.png'),
      3: _dragTarget(answer: 3, path: 'assets/images/squareblack.png'),
      1: _dragTarget(answer: 1, path: 'assets/images/circleblack.png'),
    };
    super.initState();
  }

  Draggable _draggable({required int data, required String path}) {
    return Draggable<int>(
        data: data,
        child: Container(height: 70, width: 70, child: Image.asset(path)),
        onDragCompleted: () {
          dragCompleted(data);
        },
        childWhenDragging: ColorFiltered(
            child: Container(
              height: 70,
              width: 70,
              child: Image.asset(path),
            ),
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate)),
        feedback: Container(
          height: 70,
          width: 70,
          child: Image.asset(path),
        ));
  }

  DragTarget _dragTarget({required int answer, required String path}) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          height: 70,
          width: 70,
          child: Image.asset(path),
        );
      },
      onWillAccept: (data) {
        return data == answer;
      },
      onAccept: (data) {
        dragCompleted(answer);
      },
    );
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
                Navigator.pushNamed(context, '/mapping_animals');
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

  int result = 0;

  void checkresult() {
    setState(() {
      if (result == 8) {
        showSimpleDialog();
        dref.update({'mapping_shape': 'win'});
      }
    });
  }

  dragCompleted(int data) {
    setState(() {
      result++;
      checkresult();

      dragList[data] = Container(
        height: 70,
        width: 70,
        child: Image.asset('assets/images/checked.png'),
      );

      targetList[data] = Container(
          height: 70,
          width: 70,
          child: Image.asset('assets/images/checked.png'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                  ),
                ))
              ],
            ),
            Container(
              child: Text(
                'Can you\nmatch by',
                style: TextStyle(fontSize: 50, color: Colors.blue[100]),
              ),
            ),
            Container(
              child: Text(
                'SHAPE?',
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Stack(children: [
              lightblueWigetBuild(context, 400, 370),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 370.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showSimpleDialog();
                        },
                        child: Container(
                          height: 50,
                          width: 290,
                          child: const Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: dragList.values.toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 130.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: targetList.values.toList(),
                    ),
                  )
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
