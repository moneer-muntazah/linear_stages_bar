import 'package:flutter/widgets.dart';
import 'dependencies.dart';

@immutable
class LinearStagesBar_CustomPainter extends CustomPainter {
  LinearStagesBar_CustomPainter(
  {this.presentColor,
  this.pastColor,
  this.futureColor,
  this.thumbsRadius,
  this.lastStageIsCancel,
  this.stages,
  this.textDirection})
      : assert(stages != null && stages.length >= 2);

  final Color presentColor;
  final Color pastColor;
  final Color futureColor;
  final double thumbsRadius;
  final bool lastStageIsCancel;
  final List<Stage> stages;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {

  }

    @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}