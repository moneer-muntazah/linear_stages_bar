//import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class LinearStagesBar extends LeafRenderObjectWidget {
  // static const MethodChannel _channel =
  //     const MethodChannel('linear_stages_bar');
  //
  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  LinearStagesBar(
      {required this.presentColor,
      required this.pastColor,
      required this.staleColor,
      required this.thumbsSize});

  final Color presentColor;
  final Color pastColor;
  final Color staleColor;
  final double thumbsSize;

  @override
  _RenderLinearStagesBar createRenderObject(BuildContext context) {
    return _RenderLinearStagesBar();
  }

  @override
  void updateRenderObject(BuildContext context, _RenderLinearStagesBar bar) {}

  @override
  debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

class _RenderLinearStagesBar extends RenderBox {
  static double _tempHardCodedDesiredHeight = 40;

  _RenderLinearStagesBar();

  @override
  void performLayout() {
    size = constraints
        .constrain(Size(constraints.maxWidth, _tempHardCodedDesiredHeight));
  }
}
