import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class LinearStagesBar extends LeafRenderObjectWidget {
  LinearStagesBar(
      {this.presentColor,
      this.pastColor,
      this.futureColor,
      this.textDirection});

  final Color? presentColor;
  final Color? pastColor;
  final Color? futureColor;
  final TextDirection? textDirection;

  @override
  _RenderLinearStagesBar createRenderObject(BuildContext context) {
    return _RenderLinearStagesBar(
        presentColor: presentColor ?? Theme.of(context).primaryColor,
        pastColor: pastColor ?? Theme.of(context).accentColor,
        futureColor: futureColor ?? Theme.of(context).backgroundColor,
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
  static double _hardCodedDesiredHeight = 40;
  static double _hardCodedDesiredWidth = 200;

  _RenderLinearStagesBar(
      {required Color presentColor,
      required Color pastColor,
      required Color futureColor,
      required this.textDirection})
      : _presentColor = presentColor,
        _pastColor = pastColor,
        _futureColor = futureColor;

  @override
  void performLayout() {
    size = constraints
        .constrain(Size(constraints.maxWidth, _hardCodedDesiredHeight));
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

  TextDirection textDirection;

  @override
  double computeMinIntrinsicWidth(double height) => _hardCodedDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _hardCodedDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _hardCodedDesiredHeight;

  @override
  double computeMaxIntrinsicHeight(double width) => _hardCodedDesiredHeight;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    // canvas.save();
    // canvas.translate(offset.dx, offset.dy);

    final presentPaint = Paint()
          ..color = presentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
        pastPaint = Paint()
          ..color = pastColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
        futurePaint = Paint()
          ..color = futureColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    //canvas.restore();
  }

  @override
  bool get isRepaintBoundary => true;
}
