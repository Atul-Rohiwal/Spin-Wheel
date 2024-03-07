
import 'dart:async';
class TimerService {
  late Timer _timer;
  late int _countdown;

  Function(int)? _onTick;
  Function? _onComplete;

  TimerService({
    required Function(int) onTick,
    Function? onComplete,
  }) {
    _onTick = onTick;
    _onComplete = onComplete;
    _countdown = 10;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown >= 0) {
        _onTick?.call(_countdown);
        _countdown--;
      } else {
        // Countdown completed
        _timer.cancel();
        _onComplete?.call();
      }
    });
  }

  void restartTimer() {
    _countdown = 10;
    _startTimer();
  }

  void cancelTimer() {
    _timer.cancel();
  }
}