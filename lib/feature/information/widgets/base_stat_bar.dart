import 'package:flutter/material.dart';

class BaseStatBar extends StatelessWidget {
  BaseStatBar({required this.rawScore, required this.barWidth});

  final int rawScore;
  final double barWidth;

  double _scoreWidth(int score) {
    return (score * barWidth) / 200;
  }

  Color barColor(int score) {
    var x = (score * barWidth) / 200;
    if (x >= 133.3) {
      return Colors.green;
    } else if (x >= 66.7) {
      return Colors.yellow.shade800;
    } else {
      return Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          height: 5,
          width: barWidth,
          decoration: BoxDecoration(
            color: isDark ? Colors.black26 : Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        Container(
          height: 5,
          width: _scoreWidth(rawScore),
          decoration: BoxDecoration(color: barColor(rawScore), borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ],
    );
  }
}
