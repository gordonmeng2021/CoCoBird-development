import 'package:flutter/material.dart';

class FontBuild extends StatefulWidget {
  String text;
  double? fontSize;

  Color color;
  FontBuild(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.color})
      : super(key: key);

  @override
  _FontBuildState createState() => _FontBuildState();
}

class _FontBuildState extends State<FontBuild> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(fontSize: widget.fontSize, color: widget.color),
    );
  }
}
