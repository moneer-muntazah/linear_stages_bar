import 'package:flutter/material.dart';
import 'package:linear_stages_bar/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const stages = <Stage>[
    Stage(text: "one", status: StageStatus.past),
    Stage(text: "two", status: StageStatus.past),
    Stage(text: "three", status: StageStatus.past),
    Stage(text: "four", status: StageStatus.present),
    Stage(text: "five", status: StageStatus.future),
    Stage(text: "six", status: StageStatus.future)
  ];

  static const presentColor = Colors.cyan,
      pastColor = Colors.redAccent,
      futureColor = Colors.blueGrey;

  static const lastStageIsCancel = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leaf = LinearStagesBar_Leaf(
      presentColor: presentColor,
      pastColor: pastColor,
      futureColor: futureColor,
      stages: stages,
      lastStageIsCancel: lastStageIsCancel,
      textDirection: TextDirection.ltr,
    );

    final paint = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 100, minWidth: double.infinity),
      child: CustomPaint(
        painter: LinearStagesBar_CustomPainter(
          context: context,
          presentColor: presentColor,
          pastColor: pastColor,
          futureColor: futureColor,
          stages: stages,
          lastStageIsCancel: lastStageIsCancel,
          textDirection: TextDirection.ltr,
        ),
      ),
    );

    return MaterialApp(
      // locale: Locale('en', 'en_US'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('CustomPaint'),
              const SizedBox(height: 10),
              Container(
                color: Colors.green[50],
                child: leaf,
              ),
              const SizedBox(height: 100),
              Text('LeafRenderObjectWidget'),
              const SizedBox(height: 10),
              Container(
                color: Colors.red[50],
                child: paint,
              )
            ],
          ),
        ),
      ),
    );
  }
}
