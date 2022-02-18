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


class AddLocalisation extends StatelessWidget {
   AddLocalisation({Key? key}) : super(key: key);
    var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
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
                            "localisation_text".tr(),
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
                          title: "agence".tr(),
                          textController: cubit.localisation_agence,
                          type: TextInputType.name,
                          hint: "agence".tr(),
                          suffixIcon: Icons.local_convenience_store,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.localisation_agence.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "ville".tr(),
                          textController: cubit.localisation_ville,
                          type: TextInputType.name,
                          hint: "ville".tr(),
                          suffixIcon: Icons.local_library_sharp,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.localisation_ville.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "tele_1".tr(),
                          textController: cubit.localisation_tele_1,
                          type: TextInputType.phone,
                          hint: "tele_1_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.localisation_tele_1.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "tele_2".tr(),
                          textController: cubit.localisation_tele_2,
                          type: TextInputType.phone,
                          hint: "tele_2_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.localisation_tele_2.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          title: "tele_3".tr(),
                          textController: cubit.localisation_tele_3,
                          type: TextInputType.phone,
                          hint: "tele_3_place_holder".tr(),
                          suffixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.localisation_tele_3.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                           InputField(
                          title: "voiture".tr(),
                          textController: cubit.voiture,
                          type: TextInputType.name,
                          hint: "voiture_place_holder".tr(),
                          suffixIcon: Icons.car_rental,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.voiture.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                           InputField(
                          title: "matricule".tr(),
                          textController: cubit.matricule,
                          type: TextInputType.name,
                          hint: "matricule_place_holder".tr(),
                          suffixIcon: Icons.car_rental,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.matricule.text = value.toString();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                           InputField(
                          title: "couleur".tr(),
                          textController: cubit.couleur,
                          type: TextInputType.name,
                          hint: "couleur_place_holder".tr(),
                          suffixIcon: Icons.color_lens,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "empty_email".tr();
                            } else {
                              cubit.couleur.text = value.toString();
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
                                  cubit.createLocalisation(context: context);
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