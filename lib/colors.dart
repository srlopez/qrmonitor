import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_controller.dart';

const openServicesITColor = "6A0A57";
mainColor(BuildContext context) => HexColor.fromHex(
    Get.find<AppController>().store.color); //Colors.amber[900];
//mainColor(context) => Theme.of(context).primaryColorDark;

overlayColor(BuildContext context) =>
    Theme.of(context).canvasColor.withAlpha(200);
// overlayColor: ctrl.isDark
//     ? Colors.white70
//     : Colors.black87,

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.tryParse(buffer.toString(), radix: 16) ??
        int.parse(openServicesITColor, radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';
}
