import 'package:flutter/material.dart';

class CounterListTile extends StatefulWidget {
  String name;
  int count;
  Function(int) onCountChanged;

  CounterListTile({this.name, this.onCountChanged, this.count = 0});

  CounterListTileState createState() => CounterListTileState();
}

class CounterListTileState extends State<CounterListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red,),
            onPressed: () {
              if (widget.count > 0) {
                setState(() {
                  widget.count--;
                });
                widget.onCountChanged(widget.count);
              }
            },
          ),
          Text(widget.count.toString()),
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.green,),
            onPressed: () {
              setState(() {
                widget.count++;
              });
              widget.onCountChanged(widget.count);
            },
          )
        ],
      ),
    );
  }
}