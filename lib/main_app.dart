// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('main_app.html')
library boardgame_timer.lib.main_app;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:boardgame_timer/config/config.dart';
import 'package:boardgame_timer/sound/sound_player.dart';
import 'package:boardgame_timer/vo/player.dart';
import 'package:intl/intl.dart';
import 'package:polymer_elements/iron_media_query.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import "package:observe/observe.dart";
import "package:polymer_autonotify/polymer_autonotify.dart"
    show AutonotifyBehavior;

/// Uses [PaperInput]
@PolymerRegister('main-app')
class MainApp extends PolymerElement with AutonotifyBehavior, Observable {
  Config _cfg = new Config();

  @observable
  @property
  Player currentPlayer;

  @observable
  @property
  int currentRound = 0;

  List<Player> _roundEndList = new List<Player>();

  @observable
  @property
  String playerName;

  SoundPlayer sp = new SoundPlayer();
  Timer _countdownTimer;
  Timer _warningTimer;

  //每回合秒數 from user input
  @observable
  @property
  String eachRoundTimeSecLabel = "30";

  //每回合秒數
  int _eachRoundTimeMS = 0;

  //show timeLeft to user
  @observable
  @property
  String timeLeftLabel = "";

  int _timeLeftMS = 99999;

  //record dateTime when player tap start or next player.
  DateTime _dateTime;

  NumberFormat nf = new NumberFormat("###.000");

  static final Duration WARNING_INTERVAL = const Duration(milliseconds: 1000);
  static final Duration COUNTDOWN_INTERVAL = const Duration(milliseconds: 167);

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
    this.currentPlayer = this._cfg.players[0];
    this.playerName = this.currentPlayer.name;
  }

  @Listen('btnAlarmStart.tap')
  void btnAlarmStartTapHandler(event, [_]) {
    this._showMainBtnStage(false, true);
    this._startCountdown();
  }

  @Listen('btnAlarmStop.tap')
  void btnAlarmStopTapHandler(event, [_]) {
    this._showMainBtnStage(true, false);
    this._stopCountdown();
  }

  void _startCountdown() {
    print("startCountdown...");
    this.timeLeftLabel = this.eachRoundTimeSecLabel;
    this._eachRoundTimeMS = int.parse(this.eachRoundTimeSecLabel) * 1000;
    this._dateTime = new DateTime.now();
    this._countdownTimer = new Timer.periodic(COUNTDOWN_INTERVAL, countdown);
    this._warningTimer = new Timer.periodic(WARNING_INTERVAL, warningHandler);
  }

  void _stopCountdown() {
    this._countdownTimer.cancel();
    this._warningTimer.cancel();
  }

  void _showMainBtnStage(bool start, bool stop) {
    (querySelector("#btnAlarmStart") as PaperButton).hidden = !start;
    (querySelector("#btnAlarmStop") as PaperButton).hidden = !stop;
  }

  void countdown(Timer timer) {
    int elapsedTimeMS =
        new DateTime.now().difference(this._dateTime).inMilliseconds;
    this._timeLeftMS = this._eachRoundTimeMS - elapsedTimeMS;
    if (this._cfg.STOP_WHEN_COUNTDOWN_ZERO && (this._timeLeftMS <= 0)) {
      this._countdownTimer.cancel();
      this._warningTimer.cancel();
    } else if ((this._timeLeftMS <= 0)) {
      this._countdownTimer.cancel();
      this._warningTimer.cancel();
      //switch to next player
      this._switchNextPlayer();
      this._startCountdown();
    }
    this.timeLeftLabel =
        nf.format((this._eachRoundTimeMS - elapsedTimeMS) / 1000);
  }

  void warningHandler(Timer timer) {
    if (this._timeLeftMS <= 11000) {
      sp.playSound(SoundType.warning);
    }
  }

  void _switchNextPlayer2() {}

  //切換至下一位玩家
  void _switchNextPlayer() {
    if (this.currentPlayer == null) {
      this.currentPlayer = this._cfg.players.removeAt(0);
    } else if (this._cfg.players.length == this._roundEndList.length) {
      //1 round complete
      this._cfg.players.addAll(this._roundEndList);
      this.currentPlayer = this._cfg.players.removeAt(0);
      ++currentRound;
    } else {
      this._roundEndList.add(this.currentPlayer);
    }
    this.playerName = this.currentPlayer.name;
  }

  // Optional lifecycle methods - uncomment if needed.

  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of main-app is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as a class) of an instance of
  /// main-app is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
    super.attributeChanged(name, oldValue, newValue);
  }

  /// Called when main-app has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {}
}
