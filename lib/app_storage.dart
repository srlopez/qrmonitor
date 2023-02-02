import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage extends GetxController {
  final box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  // GUI
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void toogleTheme(bool val) => box.write('darkmode', val);

  int get msTimeout => box.read<int>('mstimeout') ?? 3000;
  set msTimeout(int val) => box.write('mstimeout', val);

  String get color =>
      box.read('color') ?? "#6a0a57"; //"#ff6f00"; //Colors.amber[900]!.toHex();
  set color(String val) => box.write('color', val);

  // DB
  String get host => box.read('host') ?? '127.0.0.1';
  set host(String val) => box.write('host', val);

  int get port => box.read<int>('port') ?? 3306;
  set port(int val) => box.write('port', val);

  String get user => box.read('user') ?? 'root';
  set user(String val) => box.write('user', val);

  String get password => box.read('password') ?? '';
  set password(String val) => box.write('password', val);

  String get database => box.read('database') ?? '';
  set database(String val) => box.write('database', val);
}
