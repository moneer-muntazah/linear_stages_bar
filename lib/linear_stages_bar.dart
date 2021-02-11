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

  @override
  _RenderLinearStagesBar createRenderObject(BuildContext context) {
    return _RenderLinearStagesBar();
  }
}

class _RenderLinearStagesBar extends RenderBox {

}