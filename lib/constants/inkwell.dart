import 'package:flutter/material.dart';
import 'colorConstant.dart';

class DrawerButtons extends StatelessWidget {
  final String buttonTitle;
  final Icon buttonIcon;
  final Function onPressed;
  DrawerButtons({this.buttonTitle, this.buttonIcon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: ListTile(
            title: Text(
              buttonTitle,
              style: TextStyle(
                  color: kwhiteAlternateColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600),
            ),
            leading: buttonIcon,
          ),
        ),
        SizedBox(
          width: 200.0,
          height: 10.0,
          child: Divider(
            height: 3.0,
            color: kwhiteAlternateColor,
          ),
        ),
      ],
    );
  }
}
