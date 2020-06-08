import 'package:flutter/material.dart';

class InformationViewContainer extends StatelessWidget {

  InformationViewContainer({@required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: children,
      ),
    );
  }
}