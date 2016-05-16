library boardgame_timer.lib.vo.player;

import 'dart:math';
import 'package:boardgame_timer/config/color_util.dart';
import 'package:polymer/polymer.dart';

class Player {
  String id;
  String name;
  String color;

  Player(String id, String name) {
    this.id = id;
    this.name = name;
    this.color = ColorUtil.random();
  }
}
