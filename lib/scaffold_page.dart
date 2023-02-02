import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'app_controller.dart';
import 'qr_data_page.dart';
import 'dialogs.dart';
import 'colors.dart';

class ScaffoldPage extends StatelessWidget {
  ScaffoldPage({super.key}) : super();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: TextButton(
                onPressed: () {
                  _.resetQrCode();
                },
                child: Text(
                  _.qrCode,
                  textScaleFactor: 1.4,
                  style: const TextStyle(
                      color: Colors.white, decoration: TextDecoration.none),
                )),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            actions: [
              Switch(
                  activeColor: mainColor(context),
                  value: _.isDark,
                  onChanged: (val) {
                    _.toogleTheme(dark: !_.isDark);
                  }),
              PopupMenuButton<int>(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(value: 0, child: Text("DB Params")),
                  const PopupMenuItem<int>(
                      value: 1, child: Text("User Preferences")),
                  const PopupMenuDivider(),
                  const PopupMenuItem<int>(value: 2, child: Text("About ...")),
                ];
              }, onSelected: (value) {
                if (value == 0) {
                  showDBConfig(context, _);
                } else if (value == 1) {
                  showPreferences(context, _);
                } else if (value == 2) {
                  showAbout(context);
                }
              }),
            ]),
        // Página para mostrar resultados
        body: const DataPage(),
        //bottomSheet: SizedBox(height: 30),
        bottomNavigationBar: SizedBox(
          height: AppBar().preferredSize.height + 26,
          child: Container(
            color: Colors.grey.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 20),
                ElevatedButton(
                    style: elevatedButtonStyle(context),
                    onPressed: _.toogleCamera,
                    child: FutureBuilder(
                      future: _.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Icon(snapshot.data == _.facingFront
                              ? Icons.camera_rear
                              : Icons.camera_front); //CameraFacing.front
                        } else {
                          return const Icon(Icons.camera_rear);
                        }
                      },
                    )),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: elevatedButtonStyle(context),
                  onPressed: _.toogleAction,
                  child: Icon(_.isPaused ? Icons.play_arrow : Icons.pause),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                    style: elevatedButtonStyle(context),
                    onPressed: _.toogleFlash,
                    child: FutureBuilder(
                      future: _.getFlashStatus(),
                      builder: (context, snapshot) => Icon(
                          snapshot.data ?? false
                              ? Icons.flash_off
                              : Icons.flash_on),
                    )),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
