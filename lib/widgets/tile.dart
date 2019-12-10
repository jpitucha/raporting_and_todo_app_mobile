import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String text;
  final String icon;
  final String routeTo;

  Tile(this.text, this.icon, this.routeTo);

  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(widget.icon, height: 115.0),
                SizedBox(height: 10.0,),
                FlatButton(
                  child: Text(widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color.fromARGB(0xff, 0xd7, 0x64, 0x00))),
                        onPressed: () {
                          Navigator.pushNamed(context, widget.routeTo);
                        },
                )
                ],
            ));
  }
}
