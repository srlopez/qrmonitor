import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_controller.dart';
import 'scaffold_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //final QrController qr = QrController();
  final AppController ctrl = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ctrl.qrctrl.buildQrView(context, ctrl),
      ScaffoldPage(),
    ]);
  }
}
