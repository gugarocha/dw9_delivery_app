import 'package:flutter/material.dart';

import 'app/core/config/env.dart';
import 'app/dw9_delivery_app.dart';

Future<void> main() async {
  await Env.i.load();
  runApp(Dw9DeliveryApp());
}

