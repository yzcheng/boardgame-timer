library boardgame_timer.lib.vo.game;

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:boardgame_timer/vo/player.dart';
import 'package:observe/observe.dart';

class Game extends Observable {
  String id = new Uuid().v1();
  DateTime startTime;
  int elapsedTimeMS;
  List<Player> players;
  Timer _timer;

  static final Duration INTERVAL = const Duration(milliseconds: 1000);
  Game() {}

  //start the game
  void start() {
    this.startTime = new DateTime.now();
    print("game start:" +
        new DateFormat("yyyyMMdd HH:mm:ss").format(this.startTime));
    this._timer = new Timer.periodic(INTERVAL, this.calcElapsedTime);
  }

  void stop() {
    this._timer.cancel();
    this.calcElapsedTime(null);
    print("totalGameTime:" + elapsedTimeMS.toString());
  }

  void calcElapsedTime(Timer timer) {
    elapsedTimeMS =
        new DateTime.now().difference(this.startTime).inMilliseconds;
  }
}
