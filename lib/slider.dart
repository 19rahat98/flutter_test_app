import 'package:flutter/material.dart';

import 'bloc/bloc_slider.dart';

class SliderAnimation extends StatelessWidget {
  SliderBloc sliderBlocBloc = SliderBloc();
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int>(
            stream: sliderBlocBloc.pressedCount,
            builder: (context, snapshot) {
              return Text(
                'Flutter Slider Bloc - ${snapshot.data.toString()}',
              );
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
                stream: sliderBlocBloc.pressedCount,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data.toString()}',
                    style: Theme.of(context).textTheme.display1,
                  );
                }
               ),
            StreamBuilder<int>(
                  stream: sliderBlocBloc.pressedCount,
                  builder: (context, snapshot) {
                    return Slider (
                        value: _currentSliderValue,
                        min: 0,
                        max: 100,
                        label: _currentSliderValue.round ( ).toString ( ),
                        onChanged: (double value) {
                          sliderBlocBloc.sliderValueStream.add (
                              value.toInt ( ) );
                          _currentSliderValue = snapshot.data.toDouble();

                        } );
                  }
                ),
          ],
        ),
      ),
    );
  }
}

