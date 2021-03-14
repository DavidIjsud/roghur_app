import 'package:flutter/material.dart';
import 'package:roghurapp/constants/ui.dart';

class ErrorCustom extends StatelessWidget {
  final String message;

  ErrorCustom({
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(UI.paddingError),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
