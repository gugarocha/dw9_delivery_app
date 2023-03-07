import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
    providers: [
      Provider(
        create: (context) => LoginController(context.read()),
      ),
    ],
    child: const LoginPage(),
  );
}