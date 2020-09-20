import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class AnimatedPainterTest extends StatefulWidget {
  @override
  _AnimatedPainterTestState createState() => _AnimatedPainterTestState();
}

class _AnimatedPainterTestState extends State<AnimatedPainterTest>
    with SingleTickerProviderStateMixin {
  var _radius = 100.0;
  var _radians = 0.0;
  double _progress = 0.0;
  bool complited = false;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    Tween<double> _rotationTween = Tween(begin: 0.0, end: 4.0);

    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          complited = true;
          //controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          //controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizer'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomPaint(
                      //foregroundPainter: MyPainter(_progress),
                      painter: PointPainter(_radius, animation.value),
                      //child: Container(),
                    ),
                    CustomPaint(
                      painter: MyPainter(_progress),
                      //child: Container(),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Size'),
            ),
            RaisedButton(
              onPressed: () => controller.animateBack(0),
              child: Text('press me to start the animation'),
            ),
            Slider(
              value: _radius,
              min: 10.0,
              max: MediaQuery.of(context).size.width / 2,
              onChanged: (value) {
                setState(() {
                  _radius = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// FOR PAINTING THE TRACKING POINT
class PointPainter extends CustomPainter {
  final double radius;
  final double radians;

  PointPainter(this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    var innerCirclePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    print(radians);
    var path = Path();

    Offset center = Offset(size.width / 2, size.height / 2);

    path.moveTo(center.dx, center.dy);

    // For drawing the inner circle
/*    if (math.cos(radians) < 0.0) {
      canvas.drawCircle(center, -radius * math.cos(radians), innerCirclePaint);

    } else {
      canvas.drawCircle(center, radius * math.cos(radians), innerCirclePaint);

    }*/
    canvas.drawCircle(center, -radius * math.cos(radians), innerCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  double _progress;

  MyPainter(this._progress);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = ui.PointMode.polygon;
/*    final points = [
      Offset(60 / _progress, 80  / _progress),
      Offset(100  / _progress, 115  / _progress),
      Offset(200  / _progress, 50  / _progress),
    ];*/
    final points = [
      Offset(60 * 0.1 * _progress, 80 * 0.1 * _progress),
      Offset(100 * 0.1 * _progress, 115 * 0.1 * _progress),
      Offset(200 * 0.1 * _progress, 50 * 0.1 * _progress),
    ];
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
