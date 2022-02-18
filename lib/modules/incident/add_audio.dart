import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/incident/add_society.dart';
import 'package:incidence_front/shared/components/button.dart';
import 'package:incidence_front/shared/components/input.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAudio extends StatelessWidget {
  AddAudio({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getAllType(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          context.watch<LanguageController>();
          return Scaffold(
            backgroundColor: Themes.light.backgroundColor,
            appBar: _appBar(context: context),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: Text(
                          "audio_text".tr(),
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
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 150),
                        child: Center(
                          child: /* IconButton(
                            icon:Icon(Icons.mic,size: 70.0,),
                           onPressed: (){
                           },
                           ) */
                              ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(6.0),
                              side: BorderSide(
                                color: Colors.red,
                                width: 4.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Colors.white,
                              elevation: 9.0,
                            ),
                            onPressed: () {
                              if (!AppCubit.index) {
                                cubit.startRecording();
                                AppCubit.index = !AppCubit.index;
                              } else {
                                AppCubit.index = !AppCubit.index;

                                cubit.stopRecording();
                              }
                            },
                            icon: Icon(
                              Icons.mic,
                              color: primaryClr,
                              size: 100.0,
                            ),
                            label: Text(''),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
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
                              if (formkey.currentState!.validate()) {
                                if (cubit.selected == "Client Particulier") {
                                  cubit.createClient(context: context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddSociety(
                                            firstname: cubit.firstname.text,
                                            lastname: cubit.lastname.text,
                                            cin: cubit.cin.text),
                                      ));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
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
