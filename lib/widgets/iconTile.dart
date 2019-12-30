import 'package:flutter/material.dart';

class IconTile extends StatefulWidget {
  final String text;
  final String icon;
  final String routeTo;

  IconTile(this.text, this.icon, this.routeTo);

  _IconTileState createState() => _IconTileState();
}

class _IconTileState extends State<IconTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              child: Column(
                children: <Widget>[
                  Image.asset(widget.icon, height: 90.0),
                  SizedBox(height: 10.0),
                  Text(widget.text, style: TextStyle(fontSize: 24.0, color: Colors.blue))
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, widget.routeTo);
              },
            )
          ],
        ));
  }
}
