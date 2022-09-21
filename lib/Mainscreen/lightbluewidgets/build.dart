import 'package:flutter/material.dart';

Widget lightblueWigetBuild(
    BuildContext context, double _width, double _height) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlue[50]),
        height: _height,
        width: _width,
      ),
    ),
  );
}

Widget blueWigetBuild(BuildContext context, double _width, double _height) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlue[800]),
        height: _height,
        width: _width,
      ),
    ),
  );
}
