import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double padding;
  ButtonCustom({
    @required this.title,
    @required this.onPressed,
    this.padding = 14,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      textColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(title),
      ),
    );
  }
}
