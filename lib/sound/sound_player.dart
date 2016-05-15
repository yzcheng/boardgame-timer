library boardgame_timer.lib.config.sound.sound_player;

import 'dart:html';
import 'dart:web_audio';
import 'dart:async';

class SoundPlayer {
  AudioBufferSourceNode sound1;

  AudioContext audioContext = new AudioContext();
  AudioBuffer bufSound1;

  //constructor
  SoundPlayer() {
    initSound("sounds/se_maoudamashii_se_sound13.ogg");
    // initSound("sounds/倒數音樂變快那一段.mp3");
  }

  Future initSound(String path) async {
    HttpRequest request =
        await HttpRequest.request(path, responseType: "arraybuffer");
    bufSound1 = await audioContext.decodeAudioData(request.response);

    // AudioBufferSourceNode sound = audioContext.createBufferSource();
    // sound = audioContext.createBufferSource();
    // sound.buffer = buffer;
    // sound.connectNode(audioContext.destination);
  }

  playSound(SoundType soundType) {
    AudioBufferSourceNode sound = audioContext.createBufferSource();
    sound = audioContext.createBufferSource();

    switch (soundType) {
      case SoundType.warning:
        sound.buffer = bufSound1;
        break;
      default:
        break;
    }
    sound.connectNode(audioContext.destination);
    // play it now
    sound.start(audioContext.currentTime);
  }

  // playFile(Sound sound) {
  //   //GainNode gainNode = audioContext.createGain();
  //
  //   // get the audio file
  //   return HttpRequest
  //       .request("sounds/se_maoudamashii_se_sound13.ogg",
  //           responseType: "arraybuffer")
  //       .then((HttpRequest request) {
  //     // decode it
  //     return audioContext
  //         .decodeAudioData(request.response)
  //         .then((AudioBuffer buffer) {
  //       AudioBufferSourceNode source = audioContext.createBufferSource();
  //       source.buffer = buffer;
  //       source.connectNode(audioContext.destination);
  //       // play it now
  //       source.start(audioContext.currentTime);
  //     });
  //   });
  // }
}

enum SoundType { warning }
