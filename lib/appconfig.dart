import 'package:flutter/cupertino.dart';

class AppConfig {
  var width;
  var height;
  var blockSizeHorizontal;
  var blockSizeVertical;

  AppConfig(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
  }
}
