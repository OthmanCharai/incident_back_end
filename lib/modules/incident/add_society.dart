import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/shared/components/button.dart';
import 'package:incidence_front/shared/components/input.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class AddSociety extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String cin;

  AddSociety(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.cin})
      : super(key: key);
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          print(cin);
          print(lastname);
          print(firstname);
          cubit.cin.text = cin;
          cubit.firstname.text = firstname;
          cubit.lastname.text = lastname;

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
                            "society_text".tr(),
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
                        InputField(
                          title: "ville".tr(),
                          textController: cubit.society_ville,
                          type: TextInputType.name,
                          hint: "ville_place_holder".tr(),
                          suffixIcon: Icons.location_city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.society_ville.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "ice".tr(),
                          textController: cubit.ice,
                          type: TextInputType.name,
                          hint: "ice_place_holder".tr(),
                          suffixIcon: Icons.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.ice.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gerant".tr(),
                          textController: cubit.society_gerant,
                          type: TextInputType.name,
                          hint: "gerant_place_holder".tr(),
                          suffixIcon: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.society_gerant.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "rip".tr(),
                          textController: cubit.rip,
                          type: TextInputType.streetAddress,
                          hint: "rip_place_holder".tr(),
                          suffixIcon: Icons.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.rip.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "gsm".tr(),
                          textController: cubit.society_gsm,
                          type: TextInputType.phone,
                          hint: "gerant_place_holder".tr(),
                          suffixIcon: Icons.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.society_gsm.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyButton(
                              label: "suivant".tr(),
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.createSociety(context: context);
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
