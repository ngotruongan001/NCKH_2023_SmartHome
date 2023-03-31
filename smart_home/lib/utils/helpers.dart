import 'package:flutter/material.dart';

class Helpers {
  static String getLetterInitial(String name) {
    try {
      var wordList = name.trim().split(' ');
      var letters = '';
      if (wordList.isEmpty) {
        letters = '';
      } else if (wordList.length == 1) {
        var firstWord = wordList[0];
        if (firstWord.characters.length > 1) {
          letters = wordList[0][0] + wordList[0][1];
        } else {
          letters = wordList[0][0];
        }
      } else {
        letters = wordList[0][0] + wordList[wordList.length - 1][0];
      }
      return letters.toUpperCase();
    } catch (_) {
      return '';
    }
  }
}
