// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('main_app.html')
library boardgame_timer.lib.main_app;

import 'dart:html';
import 'dart:async';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_card.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import "package:observe/observe.dart";
import "package:polymer_autonotify/polymer_autonotify.dart" show AutonotifyBehavior;

/// Uses [PaperInput]
@PolymerRegister('main-app')
class MainApp extends PolymerElement with AutonotifyBehavior,Observable  {

  Timer timer;

  @property
  String text = "30";

  @observable
  @property
  String execLabel = "Start";

  @observable
  @property
  String timeLeft = "";

  int time = 0;

  var TIMEOUT = const Duration(seconds: 1);
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  @Listen('exec.tap')
  void execute(event, [_]) {
    switch(execLabel)
    {
      case "Start":
        this.timeLeft = text;
        this.time = int.parse(text);
        this.timer = new Timer.periodic(TIMEOUT, countdown);
        execLabel = "Stop";
        break;
      case "Stop":
        this.timer.cancel();
        execLabel = "Start";
    }
  }

  void countdown(Timer timer)
  {
    print('timeLeft:' + (this.timeLeft = (--this.time).toString()));
    if(this.time <= 0)
    {
      timer.cancel();
    }
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanged(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//  }
}
