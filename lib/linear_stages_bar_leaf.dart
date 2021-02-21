import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dependencies.dart';

class LinearStagesBar_Leaf extends LeafRenderObjectWidget {
  LinearStagesBar_Leaf(
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
        textDirection: textDirection ?? Directionality.of(context),
        buildContext: context);
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
      @required this.buildContext,
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

  BuildContext buildContext;
  TextDirection textDirection;
  double _thumbsRadius;
  bool lastStageIsCancel;

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

    final radius =
        (size.width) / ((stages.length < 5 ? 5 : stages.length) - 1) * 0.15;
    final distance = (size.width - 2 * radius) / (stages.length - 1);

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
          ..strokeWidth = 2.0,
        fillPaint = Paint()
          ..color = pastColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 2.0;

    Paint pickPaint(int i) {
      if (stages[i].status == StageStatus.past) return fillPaint;
      if (stages[i].status == StageStatus.present) return presentPaint;
      if (stages[i].status == StageStatus.future && noSkipping) {
        return futurePaint;
      }
      return pastPaint;
    }

    for (var i = 0; i < stages.length; i += 1) {
      final leftPoint = distance * i;

      canvas.drawCircle(Offset(radius + leftPoint, dy), radius, pickPaint(i));

      if (stages[i].status == StageStatus.past) {
        final icon =
            lastStageIsCancel && (isRtl ? i == 0 : i == stages.length - 1)
                ? Icons.close
                : Icons.done;
        final iconFontSize = radius * 1.6;
        TextPainter(
            text: TextSpan(
                text: String.fromCharCode(icon.codePoint),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: icon.fontFamily,
                    fontSize: iconFontSize)),
            textAlign: TextAlign.left,
            textDirection: textDirection)
          ..layout()
          ..paint(
              canvas,
              Offset(
                  leftPoint + radius - (iconFontSize / 2), dy - radius * 0.9));
      }

      final next = i + 1.0;
      if (next < stages.length) {
        canvas.drawLine(
            Offset(radius * 2 + leftPoint, dy),
            Offset(distance * next, dy),
            isRtl ? pickPaint(i) : pickPaint(next.toInt()));
      }

      TextPainter(
          text: TextSpan(
              text: stages[i].text,
              style: DefaultTextStyle.of(buildContext).style.copyWith(
                  color: stages[i].status == StageStatus.future && noSkipping
                      ? futureColor
                      : presentColor,
                  fontSize: radius)),
          textAlign: TextAlign.center,
          textDirection: textDirection)
        ..layout(minWidth: distance, maxWidth: distance)
        ..paint(canvas, Offset(leftPoint + radius - (distance / 2), dy + 20.0));
    }

    // canvas.drawLine(Offset(0, 0), Offset(40.0, 0), presentPaint);

    // canvas.restore();
  }

  @override
  bool get isRepaintBoundary => true;
}
