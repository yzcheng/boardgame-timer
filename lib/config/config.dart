library boardgame_timer.lib.config.config;

import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:boardgame_timer/vo/player.dart';

class Config {
  String _userId;
  Uuid _uuid = new Uuid();
  bool STOP_WHEN_COUNTDOWN_ZERO = false;

  List<Player> players = new List<Player>();

  //constructor
  Config() {
    //get user id[very important]
    this._userId = this._generateUserId();
    if (players.isEmpty) {
      //assign a default player
      String id = _uuid.v1().toString();
      players.add(new Player(id, "絕地武士"));
      players.add(new Player(_uuid.v1().toString(), "小寶"));
    }
  }

  //getting
  String get userId => this._userId;

  String _generateUserId() {
    return _uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com').toString();
  }
}
