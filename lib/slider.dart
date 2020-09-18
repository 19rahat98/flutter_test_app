import 'package:flutter/material.dart';


class SliderAnimation extends StatefulWidget {
  @override
  _SliderAnimationState createState() => _SliderAnimationState();
}

class _SliderAnimationState extends State<SliderAnimation> {

  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      min: 200,
      max: 2000,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );

  }
}
