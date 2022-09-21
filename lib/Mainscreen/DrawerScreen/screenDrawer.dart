import 'package:coocoobird_design/games/cameragame.dart';
import 'package:coocoobird_design/main.dart';
import 'package:coocoobird_design/Mainscreen/DrawerScreen/Performance.dart';
import 'package:coocoobird_design/Mainscreen/DrawerScreen/Tracking.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.blue[100],
      child: ListView(
        children: [
          const SizedBox(
            height: 48,
          ),
          buildMenuItem(
              text: 'Performance',
              icon: Icons.star_rate,
              onClicked: () => selectedItem(context, 0)),
          buildMenuItem(
            text: 'Tracking',
            icon: Icons.timeline,
            onClicked: () => selectedItem(
              context,
              1,
            ),
          ),
          buildMenuItem(
            text: 'AI camera testing',
            icon: Icons.computer,
            onClicked: () => selectedItem(
              context,
              2,
            ),
          ),
          buildMenuItem(
            text: 'AI camera Game',
            icon: Icons.computer,
            onClicked: () => selectedItem(
              context,
              3,
            ),
          )
        ],
      ),
    ));
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[700],
        ),
        title: Text(
          text,
          style: TextStyle(color: Colors.grey[700], fontSize: 20),
        ),
        hoverColor: Colors.black,
        onTap: onClicked);
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Performancepage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TrackingPage()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CameraGame()));
        break;
    }
  }
}
