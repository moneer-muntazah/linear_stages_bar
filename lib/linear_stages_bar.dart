//import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
      required this.staleColor});

  Color presentColor;
  Color pastColor;
  Color staleColor;

  @override
  _RenderLinearStagesBar createRenderObject(BuildContext context) {
    return _RenderLinearStagesBar(
        presentColor: presentColor,
        pastColor: pastColor,
        staleColor: staleColor);
  }
}

class _RenderLinearStagesBar extends RenderBox {
  _RenderLinearStagesBar(
      {required this.presentColor,
      required this.pastColor,
      required this.staleColor});

  Color presentColor;
  Color pastColor;
  Color staleColor;
}
