import 'package:flutter/material.dart';
import 'bottom_sheet.dart';

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => BottomFilterSheet(),
        );
      },
      child: Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
    );
  }
}
