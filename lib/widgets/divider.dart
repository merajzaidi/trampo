import 'package:flutter/material.dart';

class Divider1 extends StatelessWidget {
  var title = '';
  Divider1({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.all(4),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
