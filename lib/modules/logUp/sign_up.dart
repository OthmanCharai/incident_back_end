import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/shared/components/input.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var second = GlobalKey<FormState>();
  static String routeName = "/sign_up";


  @override
  Widget build(BuildContext context) {
    //Below shows the time like Sep 15, 2021
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          context.watch<LanguageController>();
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Themes.light.backgroundColor,
            appBar: _appBar(),
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
                          height: 80.0,
                        ),
                        Center(
                          child: Text(
                            "register_text".tr(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.josefinSans(
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
                        InputField(
                          title: "agence".tr(),
                          textController: cubit.agence,
                          type: TextInputType.name,
                          hint: "agence_place_holder".tr(),
                          suffixIcon: Icons.home,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.agence.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "ville".tr(),
                          textController: cubit.ville,
                          type: TextInputType.name,
                          hint: "ville_place_holder".tr(),
                          suffixIcon: Icons.location_city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.ville.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "Adr".tr(),
                          textController: cubit.address,
                          type: TextInputType.streetAddress,
                          hint: "adr_place_holder".tr(),
                          suffixIcon: Icons.local_library_sharp,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.address.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gerant".tr(),
                          textController: cubit.gerant,
                          type: TextInputType.name,
                          hint: "gerant_place_holder".tr(),
                          suffixIcon: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.gerant.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gsm_1".tr(),
                          type: TextInputType.phone,
                          textController: cubit.gsm_1,
                          hint: "gsm_1_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.gsm_1.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gsm_2".tr(),
                          textController: cubit.gsm_2,
                          type: TextInputType.phone,
                          hint: "gsm_2_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.gsm_2.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gsm_3".tr(),
                          type: TextInputType.phone,
                          textController: cubit.gsm_3,
                          hint: "gsm_3_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.gsm_3.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "fix".tr(),
                          textController: cubit.fix,
                          hint: "fix_place_holder".tr(),
                          type: TextInputType.phone,
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.fix.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "phone".tr(),
                          textController: cubit.phone,
                          hint: "phone_place_holder".tr(),
                          type: TextInputType.phone,
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.phone.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        InputField(
                          title: "login_email".tr(),
                          type: TextInputType.emailAddress,
                          textController: cubit.email,
                          hint: "login_email_place_holder".tr(),
                          suffixIcon: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.email.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        InputField(
                          isPassword: true,
                          textController: cubit.password,
                          type: TextInputType.name,
                          title: "login_password".tr(),
                          hint: "login_password_place_holder".tr(),
                          suffixIcon: Icons.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_password".tr();
                            } else {
                              cubit.password.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        _loginBtn(onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.register(
                                context: context);
                          }
                        }),
                        SizedBox(
                          height: 30.0,
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

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.light.backgroundColor,
      leading: GestureDetector(
        onTap: () {},
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
          style: GoogleFonts.josefinSans(
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
        style: GoogleFonts.josefinSans(
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
