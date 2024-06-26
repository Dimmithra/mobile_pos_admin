import 'dart:math';

import 'package:flutter/material.dart';

const kCommonWhite = Colors.white;
const kCommonBlack = Colors.black;
const kCommonBlue = Colors.blue;
const kCommondarkBlue = Color.fromARGB(255, 0, 60, 189);
const kBackgroundColor = Color.fromARGB(255, 209, 210, 211);
const kBtnPrimaryColor = Colors.blue;
const kErrorColor = Colors.red;
const kWarningColor = Colors.amber;
const kSuccessColor = Colors.blue;
const kLoaderColor = Colors.blue;
const kdropDownColor = Color.fromARGB(255, 215, 215, 215);
const kdefTextColor = Colors.black;

final List<Color> cardColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.yellow,
];

final Random random = Random();

Color getRandomColor() {
  return cardColors[random.nextInt(cardColors.length)];
}

Color randomColor = getRandomColor();
