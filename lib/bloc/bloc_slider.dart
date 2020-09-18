import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SliderBloc {
  int _sliderValue;

  SliderBloc() {
    _sliderValue = 100;
    _actionController.stream.listen(_sliderValueStream);
  }

  final _counterStream = BehaviorSubject<int>.seeded(1);

  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;

  StreamController _actionController = StreamController();
  StreamSink get sliderValueStream => _actionController.sink;

  void _sliderValueStream(data) {
    _sliderValue = data;
    _addValue.add(_sliderValue);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}