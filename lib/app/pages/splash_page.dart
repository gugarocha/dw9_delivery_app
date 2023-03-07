import 'package:flutter/material.dart';

import '../core/ui/widgets/delivery_button.dart';
import '../core/ui/helpers/size_extensions.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: context.percentHeight(0.3)),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 80),
                  DeliveryButton(
                    width: context.percentWidth(0.6),
                    height: 35,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/home');
                    },
                    label: 'ACESSAR',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
