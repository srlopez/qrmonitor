import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'app_controller.dart';
import 'data_page.dart';
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
                  // var entries =
                  //     <Tuple3<String, Function, TextEditingController>>[
                  //   Tuple3('Host', (val) => _.store.host = val.text.trim(),
                  //       TextEditingController(text: _.store.host)),
                  //   Tuple3(
                  //       'Port',
                  //       (val) => _.store.port = int.tryParse(val.text) ?? 3306,
                  //       TextEditingController(text: _.store.port.toString())),
                  //   Tuple3('Username', (val) => _.store.user = val.text.trim(),
                  //       TextEditingController(text: _.store.user)),
                  //   Tuple3(
                  //       'Password',
                  //       (val) => _.store.password = val.text.trim(),
                  //       TextEditingController(text: _.store.password)),
                  //   Tuple3(
                  //       'Database',
                  //       (val) => _.store.database = val.text.trim(),
                  //       TextEditingController(text: _.store.database)),
                  // ];

                  // showDataConfig(context, _, "MySQL settings", entries);
                  showDBConfig(context, _);
                } else if (value == 1) {
                  showPreferences(context, _);

                  // var entries =
                  //     <Tuple3<String, Function, TextEditingController>>[
                  //   // Tuple3('QRCode', (val) => _.qrCode = val.text,
                  //   //     TextEditingController(text: _.qrCode)),
                  //   Tuple3(
                  //       'Timeout (ms)',
                  //       (val) =>
                  //           _.store.msTimeout = int.tryParse(val.text) ?? 3000,
                  //       TextEditingController(
                  //           text: _.store.msTimeout.toString())),
                  //   Tuple3('Color', (val) => _.store.color = val.text.trim(),
                  //       TextEditingController(text: _.store.color)),
                  // ];

                  // showDataConfig(context, _, "User Preferences", entries);
                } else if (value == 2) {
                  showAbout(context);

                  // showAboutDialog(
                  //   context: context,
                  //   applicationIcon: Image.asset(
                  //     'assets/app_icon.png',
                  //     height: 168 * .33,
                  //     width: 168 * .33,
                  //     fit: BoxFit.contain,
                  //     // color: const Color.fromARGB(222, 255, 255, 255),
                  //     // colorBlendMode: BlendMode.dstOut,
                  //   ),
                  //   applicationName: 'OSit QRmonitor',
                  //   //applicationVersion: '0.0.1',
                  //   applicationLegalese: '©2023 openServices.eus',
                  //   children: <Widget>[
                  //     Padding(
                  //         padding: const EdgeInsets.only(top: 15),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             const Text(
                  //                 'Esta App ha sido creada gracias a los siguientes amantes de la gastronomía:\n'),
                  //             LinkButton(
                  //                 "Paco",
                  //                 "https://lafonoteca.net/wp-content/uploads/2009/11/R-3036384-1392851872-3270.jpeg",
                  //                 1.5),
                  //             const Text('    El de la Receta'),
                  //             LinkButton(
                  //                 "Héctor",
                  //                 "https://www.linkedin.com/in/hectorherrero/",
                  //                 1.5),
                  //             const Text('    El del Restaurante'),
                  //             LinkButton("Santi",
                  //                 "https://www.linkedin.com/in/srlopezh/", 1.5),
                  //             const Text('    El Cocinero'),
                  //           ],
                  //         ))
                  //   ],
                  // );
                }
              }),
            ]),
        body: const DataPage(),
        //bottomSheet: SizedBox(height: 30),
        bottomNavigationBar: SizedBox(
          height: AppBar().preferredSize.height + 26,
          child: Container(
            color: Colors.grey.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const SizedBox(width: 20),
                // FloatingActionButton(
                //   onPressed: _.incrementCounter,
                //   tooltip: 'Increment',
                //   child: const Icon(Icons.add),
                // ),
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
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     // const SizedBox(width: 20),
        //     // FloatingActionButton(
        //     //   onPressed: _.incrementCounter,
        //     //   tooltip: 'Increment',
        //     //   child: const Icon(Icons.add),
        //     // ),
        //     const SizedBox(width: 20),
        //     ElevatedButton(
        //         onPressed: _.toogleCamera,
        //         child: FutureBuilder(
        //           future: _.getCameraInfo(),
        //           builder: (context, snapshot) {
        //             if (snapshot.data != null) {
        //               return Icon(snapshot.data == _.facingFront
        //                   ? Icons.camera_rear
        //                   : Icons.camera_front); //CameraFacing.front
        //             } else {
        //               return const Icon(Icons.camera_rear);
        //             }
        //           },
        //         )),
        //     const SizedBox(width: 20),
        //     ElevatedButton(
        //       onPressed: _.toogleAction,
        //       child: Icon(_.isPaused ? Icons.play_arrow : Icons.pause),
        //     ),
        //     const SizedBox(width: 20),
        //     ElevatedButton(
        //         onPressed: _.toogleFlash,
        //         child: FutureBuilder(
        //           future: _.getFlashStatus(),
        //           builder: (context, snapshot) => Icon(snapshot.data ?? false
        //               ? Icons.flash_off
        //               : Icons.flash_on),
        //         )),
        //     const SizedBox(width: 20),
        //   ],
        // ) // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
