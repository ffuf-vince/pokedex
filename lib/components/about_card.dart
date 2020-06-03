import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    Key key,
    @required this.trailing,
    @required this.label,
  }) : super(key: key);

  final Widget trailing;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(label),
        trailing: trailing,
      ),
    );
  }
}