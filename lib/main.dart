import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStopwatch(),
    );
  }
}

class MyStopwatch extends StatefulWidget {
  @override
  _MyStopwatchState createState() => _MyStopwatchState();
}

class _MyStopwatchState extends State<MyStopwatch> {
  bool isRunning = false;
  bool isPaused = false;
  Duration duration = Duration(milliseconds: 0);
  late Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
  }

  void startStopwatch() {
    if (!stopwatch.isRunning) {
      setState(() {
        isRunning = true;
        isPaused = false;
      });

      stopwatch.start();
      updateStopwatch();
    } else {
      setState(() {
        isRunning = false;
        isPaused = true;
      });

      stopwatch.stop();
    }
  }

  void resetStopwatch() {
    setState(() {
      isRunning = false;
      isPaused = false;
      duration = Duration(milliseconds: 0);
    });

    stopwatch.reset();
  }

  void updateStopwatch() {
    if (stopwatch.isRunning) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (stopwatch.isRunning) {
          setState(() {
            duration = stopwatch.elapsed;
          });
          updateStopwatch();
        }
      });
    }
  }

  String formatMilliseconds(int milliseconds) {
    return (milliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Stopwatch App'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${formatMilliseconds(duration.inMilliseconds)}',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: startStopwatch,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: Text(
                    isRunning ? 'Stop' : 'Start',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetStopwatch,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
