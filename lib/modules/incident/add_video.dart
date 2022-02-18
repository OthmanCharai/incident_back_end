import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/incident/add_society.dart';
import 'package:incidence_front/shared/components/button.dart';
import 'package:incidence_front/shared/components/input.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:video_player/video_player.dart';

class AddVideo extends StatelessWidget {
  AddVideo({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getAllType(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          VideoPlayerController? cnt = cubit.controller;
          context.watch<LanguageController>();
          return Scaffold(
            backgroundColor: Themes.light.backgroundColor,
            appBar: _appBar(context: context),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                        ),
                        Center(
                          child: Text(
                            "video_text".tr(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gothicA1(
                              textStyle: TextStyle(
                                color: primaryClr,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "video".tr(),
                          style: GoogleFonts.gothicA1(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => isVisible = !isVisible,
                                  child: Container(
                                      height: 400,
                                      padding: EdgeInsetsDirectional.only(
                                        top: 5.0,
                                        start: 5.0,
                                        end: 5.0,
                                      ),
                                      width: double.infinity,
                                      child: cubit.file != null
                                          ? AspectRatio(
                                              aspectRatio: cubit
                                                  .controller.value.aspectRatio,
                                              child:
                                                  VideoPlayer(cubit.controller),
                                            )
                                          : Container()),
                                ),
                                Container(
                                  padding:
                                      EdgeInsetsDirectional.only(bottom: 5.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: HexColor("#fff")),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: OutlinedButton(
                                          onPressed: cubit.takeVideo,
                                          child: Icon(Icons.camera_alt,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      Container(
                                          child: OutlinedButton(
                                        onPressed: cubit.chooseVideo,
                                        child: Icon(Icons.upload_file,
                                            color: Colors.blue),
                                      ))
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyButton(
                              label: "suivant".tr(),
                              onTap: () {
                                cubit.createVideo(context: context);
                                
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _appBar({
    required BuildContext context,
  }) {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.light.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
      ),
    );
  }

  Widget _loginBtn({
    required Function() onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: primaryClr,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          "login_login_btn".tr(),
          style: GoogleFonts.gothicA1(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpLabel(String label, Color textColor) {
    return Center(
      child: Text(
        label,
        style: GoogleFonts.gothicA1(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
