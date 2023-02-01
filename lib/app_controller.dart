import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrquery/app_storage.dart';
import 'package:qrquery/mysql_service.dart';
import 'package:qrquery/qr_controller.dart';
import 'package:tuple/tuple.dart';

class AppController extends GetxController {
  final store = AppStorage();
  final mysql = Mysql();

  late QrController qrctrl;

  AppController(this.qrctrl);

  int counter = 0;
  void incrementCounter() {
    counter++;
    update();
  }

  // GUI
  bool get isDark => store.isDark;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void toogleTheme({bool dark = false}) {
    store.toogleTheme(dark);
    update();
  }

  //QR
  String qrCode = "";
  Barcode? scanData;

  setQrCode(Barcode val) async {
    if (val.code == scanData?.code) return;
    scanData = val;
    var format = describeEnum(scanData!.format);
    var code = '${scanData!.code}';
    log('Barcode Type: $format   Data: $code');

    // if (Uri.tryParse(code)?.host.isNotEmpty ?? false) {
    //   qrCode = "GO TO";
    //   map.clear();
    //   map["URL"] = Tuple2(code, "0");
    // } else {
    //   qrCode = code;
    //   map = await mysql.readQRData(code);
    // }
    map.clear();
    qrCode = code;
    map = await mysql.readQRData(code);
    if (map.isEmpty) {
      if (Uri.tryParse(code)?.host.isNotEmpty ?? false) {
        qrCode = "URI";
        map["Click to go"] = Tuple2(code, "0");
      } else {
        qrCode = format.toUpperCase();
        map[code] = Tuple2(format, "0");
      }
    }
    update();
    if (store.msTimeout > 0) {
      Future.delayed(
          Duration(milliseconds: store.msTimeout), () => resetQrCode());
    }
  }

  resetQrCode() {
    qrCode = "";
    scanData = null;
    map = {};
    update();
  }

  bool get isPaused => paused;
  CameraFacing facingFront = CameraFacing.front;

  Future<CameraFacing>? getCameraInfo() => qrctrl.controller?.getCameraInfo();

  Future<bool?>? getFlashStatus() => qrctrl.controller?.getFlashStatus();

  void toogleCamera() async {
    await qrctrl.controller?.flipCamera();
    update();
  }

  void toogleFlash() async {
    await qrctrl.controller?.toggleFlash();
    update();
  }

  bool paused = false;
  void toogleAction() {
    paused = !paused;
    if (paused) {
      qrctrl.controller?.pauseCamera();
    } else {
      qrctrl.controller?.resumeCamera();
    }
    update();
  }

  //BD
  Map<String, Tuple2<String, String>> map = {};

  Future<Map<String, Tuple2<String, String>>> readData() {
    return Future(() {
      return map;
    });
  }
}
