library boardgame_timer.lib.config.color_util;

import 'dart:math';

class ColorUtil {
  static final List<String> colorPool = [
    "#076923",
    "#db99d3",
    "#f9e024",
    "#fe483f",
    "#9bf76e",
    "#30afdf",
    "#cccccc",
    "#9453e4"
  ];

  static String random() {
    return ColorUtil.colorPool[new Random().nextInt(7)];
  }
}
