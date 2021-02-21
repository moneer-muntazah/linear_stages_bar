import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

enum StageStatus { past, present, future }

/// A PDS
@immutable
class Stage {
  final String text;
  final StageStatus status;

  const Stage({@required this.text, this.status = StageStatus.future})
      : assert(text != null && status != null);
}

class LinearStagesBar extends LeafRenderObjectWidget {
  LinearStagesBar(
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
  _RenderLinearStagesBar createRenderObject(BuildContext context) {
    return _RenderLinearStagesBar(
        presentColor: presentColor ?? Theme.of(context).primaryColor,
        pastColor: pastColor ?? Theme.of(context).accentColor,
        futureColor: futureColor ?? Theme.of(context).backgroundColor,
        thumbsRadius: thumbsRadius ?? 40.0,
        lastStageIsCancel: lastStageIsCancel ?? false,
        stages: stages ?? <Stage>[],
        textDirection: textDirection ?? Directionality.of(context));
  }

  @override
  void updateRenderObject(BuildContext context, _RenderLinearStagesBar bar) {}

  @override
  debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

class _RenderLinearStagesBar extends RenderBox {
  static double _hardCodedDesiredWidth = 200;

  _RenderLinearStagesBar(
      {@required Color presentColor,
      @required Color pastColor,
      @required Color futureColor,
      @required double thumbsRadius,
      @required List<Stage> stages,
      @required this.textDirection,
      @required this.lastStageIsCancel})
      : _presentColor = presentColor,
        _pastColor = pastColor,
        _futureColor = futureColor,
        _thumbsRadius = thumbsRadius,
        _stages = stages;

  @override
  void performLayout() {
    size = constraints.constrain(Size(constraints.maxWidth, _thumbsRadius));
  }

  Color get presentColor => _presentColor;
  Color _presentColor;

  set presentColor(Color color) {
    if (_presentColor == color) return;
    _presentColor = color;
    markNeedsPaint();
  }

  Color get pastColor => _presentColor;
  Color _pastColor;

  set pastColor(Color color) {
    if (_pastColor == color) return;
    _pastColor = color;
    markNeedsPaint();
  }

  Color get futureColor => _presentColor;
  Color _futureColor;

  set futureColor(Color color) {
    if (_futureColor == color) return;
    _futureColor = color;
    markNeedsPaint();
  }

  List<Stage> get stages => _stages;
  List<Stage> _stages;

  set stages(List<Stage> stages) {
    if (_stages == stages) return;
    _stages = stages;
    markNeedsPaint();
  }

  TextDirection textDirection;
  double _thumbsRadius;
  bool lastStageIsCancel;

  @override
  double computeMinIntrinsicWidth(double height) => _hardCodedDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _hardCodedDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _thumbsRadius;

  @override
  double computeMaxIntrinsicHeight(double width) => _thumbsRadius;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    // canvas.save();
    // canvas.translate(offset.dx, offset.dy);

    final isRtl = textDirection == TextDirection.rtl;

    final dy = size.height / 3;

    final noSkipping =
        lastStageIsCancel ? stages.last?.status != StageStatus.past : true;

    final presentPaint = Paint()
          ..color = presentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0,
        pastPaint = Paint()
          ..color = pastColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
        futurePaint = Paint()
          ..color = futureColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    canvas.drawLine(Offset(0, 0), Offset(40.0, 0), presentPaint);

    // canvas.restore();
  }

  @override
  bool get isRepaintBoundary => true;
}
