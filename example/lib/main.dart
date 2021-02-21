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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(
            // color: Colors.lightGreen,
            child: Container(
              color: Colors.pink[50],
              child: LinearStagesBar_Leaf(
                presentColor: Colors.cyan,
                pastColor: Colors.redAccent,
                futureColor: Colors.blueGrey,
                stages: <Stage>[
                  const Stage(
                    text: "one",
                    status: StageStatus.past
                  ),
                  const Stage(
                      text: "two",
                      status: StageStatus.present
                  ),
                  const Stage(
                      text: "three",
                      status: StageStatus.future
                  )
                ],
                lastStageIsCancel: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
