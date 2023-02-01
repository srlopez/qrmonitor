import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'app_controller.dart';

mainColor(BuildContext context) => HexColor.fromHex(
    Get.find<AppController>().store.color); //Colors.amber[900];
//mainColor(context) => Theme.of(context).primaryColorDark;
elevatedButtonStyle(BuildContext context) =>
    ElevatedButton.styleFrom(backgroundColor: mainColor(context));
elevatedButtonCancel(context) =>
    ElevatedButton.styleFrom(backgroundColor: Colors.white);
elevatedButtonCancelText(BuildContext context) =>
    const TextStyle(color: Colors.black);
dialogTextStyle(BuildContext context) => const TextStyle(fontSize: 24.0);

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
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';
}

showDataConfig(
  BuildContext context,
  AppController ctrl,
  String title,
  List<Tuple3<String, Function, TextEditingController>> entries,
) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          contentPadding: const EdgeInsets.only(top: 5.0),
          title: Text(
            title,
            style: dialogTextStyle(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (var i = 0; i < entries.length; i++) ...[
                ListTile(
                  title: TextField(
                    controller: entries[i].item3,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: dialogTextStyle(context),
                  ),
                  subtitle: Text(entries[i].item1),
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  minVerticalPadding: 0,
                ),
              ],
              const SizedBox(height: 15.0),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: elevatedButtonCancel(context),
                            child: Text(
                              "Cancel",
                              style: elevatedButtonCancelText(context),
                            )),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            for (var i = 0; i < entries.length; i++) {
                              entries[i].item2(entries[i].item3.value);
                            }
                            Navigator.of(context).pop();
                          },
                          style: elevatedButtonStyle(context),
                          child: const Text("Confirm"),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      });
}
