import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'qr_controller.dart';

import 'app_controller.dart';
import 'app_storage.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();

  Get.put(AppController(QrController()));

  runApp(const QrApp());
}

class QrApp extends StatelessWidget {
  const QrApp({super.key});
  @override
  Widget build(BuildContext context) => GetBuilder<AppController>(
      builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _.theme,
            home: HomePage(),
          ));
}
