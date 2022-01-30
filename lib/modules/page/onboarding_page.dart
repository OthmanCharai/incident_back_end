import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/login/sing_in.dart';

import 'package:incidence_front/modules/widget/button_widget.dart';
import 'package:incidence_front/modules/widget/home.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'onboarding_1_title'.tr(),
            body: 'onboarding_1_body'.tr(),
            image: buildImage('assets/images/a1.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'onboarding_2_title'.tr(),
            body: 'onboarding_2_body'.tr(),
            image: buildImage('assets/images/a3.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'onboarding_3_title'.tr(),
            body: 'onboarding_3_body'.tr(),
            image: buildImage('assets/images/a3.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'onboarding_4_title'.tr(),
            body: 'onboarding_4_body'.tr(),
            footer: ButtonWidget(
              text: 'onboarding_start_button'.tr(),
              onClicked: () => goToHome(context),
            ),
            image: buildImage('assets/images/a4.png'),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text('onboarding_continu_btn'.tr(),
            style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text('onboarding_skip'.tr()),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Theme.of(context).backgroundColor,
        skipFlex: 0,
        nextFlex: 0,
        // isProgressTap: false,
        // isProgress: false,
        // showNextButton: false,
        // freeze: true,
        // animationDuration: 1000,
      ),
    );
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SignIn()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),

        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: HexColor('#2B50AA'),
            fontFamily: 'RobotoMono',
            letterSpacing: 0.0),
        bodyTextStyle: TextStyle(fontSize: 20, color: Colors.black54),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: HexColor('#ECF1F6'),
      );
}
