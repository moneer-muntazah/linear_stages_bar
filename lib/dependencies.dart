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