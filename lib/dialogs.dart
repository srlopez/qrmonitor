import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'app_controller.dart';
import 'qr_data_page.dart';
import 'colors.dart';

dialogTextStyle(BuildContext context) => const TextStyle(fontSize: 24.0);
elevatedButtonStyle(BuildContext context) =>
    ElevatedButton.styleFrom(backgroundColor: mainColor(context));
elevatedButtonCancel(context) =>
    ElevatedButton.styleFrom(backgroundColor: Colors.white);
elevatedButtonCancelText(BuildContext context) =>
    const TextStyle(color: Colors.black);

showAbout(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationIcon: Image.asset(
      'assets/app_icon.png',
      height: 168 * .50,
      width: 168 * .50,
      fit: BoxFit.contain,
      // color: const Color.fromARGB(222, 255, 255, 255),
      // colorBlendMode: BlendMode.dstOut,
    ),
    applicationName: 'OSit QRmonitor',
    applicationVersion: '0.0.1',
    applicationLegalese: '©2023 openServices.eus',
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Esta App ha sido creada gracias a los siguientes amantes de la gastronomía:\n'),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinkButton("Paco",
                        "https://www.youtube.com/watch?v=m3CHfRVM9uM", 1),
                    const Text('El de la Receta 🍰'),
                    LinkButton("Héctor",
                        "https://www.linkedin.com/in/hectorherrero/", 1),
                    const Text('El del Restaurante 🏩'),
                    LinkButton(
                        "Santi", "https://www.linkedin.com/in/srlopezh/", 1),
                    const Text('El Cocinero 👨‍🍳'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    scale: 7,
                  ),
                ],
              ),
              //SizedBox(height: 20),
            ],
          ))
    ],
  );
}

showPreferences(
  BuildContext context,
  AppController ctrl,
) {
  var entries = <Tuple3<String, Function, TextEditingController>>[
    Tuple3(
        'Timeout (ms)',
        (val) => ctrl.store.msTimeout = int.tryParse(val.text) ?? 3000,
        TextEditingController(text: ctrl.store.msTimeout.toString())),
    Tuple3('Color', (val) => ctrl.store.color = val.text.trim(),
        TextEditingController(text: ctrl.store.color)),
  ];

  showDataConfig(context, "User Preferences", entries);
}

showDBConfig(
  BuildContext context,
  AppController ctrl,
) {
  var entries = <Tuple3<String, Function, TextEditingController>>[
    Tuple3('Host', (val) => ctrl.store.host = val.text.trim(),
        TextEditingController(text: ctrl.store.host)),
    Tuple3('Port', (val) => ctrl.store.port = int.tryParse(val.text) ?? 3306,
        TextEditingController(text: ctrl.store.port.toString())),
    Tuple3('Username', (val) => ctrl.store.user = val.text.trim(),
        TextEditingController(text: ctrl.store.user)),
    Tuple3('Password', (val) => ctrl.store.password = val.text.trim(),
        TextEditingController(text: ctrl.store.password)),
    Tuple3('Database', (val) => ctrl.store.database = val.text.trim(),
        TextEditingController(text: ctrl.store.database)),
  ];

  showDataConfig(context, "MySQL settings", entries);
}

showDataConfig(
  BuildContext context,
  //AppController ctrl,
  String title,
  List<Tuple3<String, Function, TextEditingController>> entries,
) {
  var colorAux = Colors.grey.shade500;
  const radio = Radius.circular(15.0);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radio),
          ),
          contentPadding: const EdgeInsets.only(top: 5.0),
          title: Text(
            title,
            style: dialogTextStyle(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(color: colorAux),
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
                    color: colorAux,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: radio, bottomRight: radio),
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
