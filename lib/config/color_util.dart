library boardgame_timer.lib.config.color_util;

import 'dart:math';
import 'package:color/color.dart';

class ColorUtil {
  static final List<HexColor> colorPool = [
    new HexColor("076923"),
    new HexColor("db99d3"),
    new HexColor("f9e024"),
    new HexColor("f9160b"),
    new HexColor("9bf76e"),
    new HexColor("30afdf"),
    new HexColor("076422"),
    new HexColor("9453e4")
  ];

  static HexColor random() {
    return ColorUtil.colorPool[new Random().nextInt(7)];
  }
}
