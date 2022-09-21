import 'dart:async';

import 'package:coocoobird_design/Mainscreen/lightbluewidgets/build.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

ValueNotifier<int> NumOfTrophies = ValueNotifier(1);
ValueNotifier<List<Widget>> TrophiesList = ValueNotifier([]);
ValueNotifier<int> NumofMedal = ValueNotifier(2);
ValueNotifier<List<Widget>> MedalList = ValueNotifier([]);

class Performancepage extends StatefulWidget {
  const Performancepage({Key? key}) : super(key: key);

  @override
  _PerformancepageState createState() => _PerformancepageState();
}

class _PerformancepageState extends State<Performancepage> {
  int TrophiesAdded = 0;

  int MedalAdded = 0;

  void AddingTrophies() {
    setState(() {
      TrophiesList.value.add(AddOneTrophies(context, 'Trial\nTrophies'));
    });
  }

  void AddingMedal() {
    setState(() {
      MedalList.value.add(AddOneMedal(context, 'Medal\nTrial'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Performance'),
      ),
      body: SingleChildScrollView(
          child: Stack(children: [
        ElevatedButton(
            onPressed: () {
              NumofMedal.value++;
              MedalAdded++;
              AddingMedal();
            },
            child: const Text('TRIAL for medal')),
        Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: ElevatedButton(
              onPressed: () {
                NumOfTrophies.value++;
                TrophiesAdded++;
                AddingTrophies();
              },
              child: const Text('TRIAL for Trophies')),
        ),
        Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 47.0),
                child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/black_human.png')),
              ),
            ),
            Center(
                child: Container(
              child: const Text(
                'Hello Jasmine!',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Stack(children: [
                lightblueWigetBuild(
                    context, 350, 300 + 110.0 * (MedalList.value.length - 1)),
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      'Awards',
                      style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                    ),
                  ), //add medals here
                  AddOneMedal(context, 'Best\nCatcher'),

                  AddOneMedal(context, 'Color\nLover'),

                  ValueListenableBuilder(
                    builder: (context, List<Widget> value, child) {
                      return Column(
                        children: value,
                      );
                    },
                    valueListenable: MedalList,
                  ),
                ]),
              ]),
            ),
            Stack(children: [
              lightblueWigetBuild(
                  context, 350, 170 + (TrophiesList.value.length - 1) * 110),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      'Trophies',
                      style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: AddOneTrophies(context, 'Fast biter\nat your age!'),
                  ),
                  ValueListenableBuilder(
                      builder: (context, List<Widget> value, child) {
                        return Column(children: value);
                      },
                      valueListenable: TrophiesList)
                ],
              ),
            ]),
          ],
        ),
      ])),
    );
  }

  Widget AddOneMedal(BuildContext context, String text) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lightBlue[50],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(left: 40, top: 20),
              child: Image.asset('assets/images/medal.png'),
            ),
            Container(
              height: 87,
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                text,
                style: TextStyle(fontSize: 35, color: Colors.blue[900]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AddOneTrophies(BuildContext context, String text) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lightBlue[50],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Image.asset('assets/images/champion.png'),
            ),
            Container(
              height: 87,
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                text,
                style: TextStyle(fontSize: 35, color: Colors.blue[900]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
