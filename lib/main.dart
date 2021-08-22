import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'cores/utils/config.dart';
import 'cores/utils/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  Config.setUpSnackBarConfig();
  await Firebase.initializeApp();
  await Config.setUpHiveLocalDB();
  runApp(MyApp());
}

