import 'package:flutter/material.dart';

import 'dependencies.dart';

@immutable
class LinearStagesBar_CustomPainter extends CustomPainter {
  LinearStagesBar_CustomPainter(
      {this.context,
      this.presentColor,
      this.pastColor,
      this.futureColor,
      this.thumbsRadius,
      this.lastStageIsCancel,
      this.stages,
      this.textDirection})
      : assert(stages != null && stages.length >= 2);

  final BuildContext context;
  final Color presentColor;
  final Color pastColor;
  final Color futureColor;
  final double thumbsRadius;
  final bool lastStageIsCancel;
  final List<Stage> stages;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.save();
    // canvas.translate(offset.dx, offset.dy);

    final textDirection = this.textDirection ?? Directionality.of(context);

    print(textDirection);

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
              style: DefaultTextStyle.of(context).style.copyWith(
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
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
