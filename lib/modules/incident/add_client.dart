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

class AddIncident extends StatelessWidget {
  AddIncident({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var a = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          context.watch<LanguageController>();
          a = "user_type".tr();
          return Scaffold(
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
                          height: 50.0,
                        ),
                        Center(
                          child: Text(
                            "incident_text".tr(),
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
                          title: "firstname".tr(),
                          textController: cubit.firstname,
                          type: TextInputType.name,
                          hint: "firstname_place_holder".tr(),
                          suffixIcon: Icons.person,
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
                          title: "lastname".tr(),
                          textController: cubit.lastname,
                          type: TextInputType.name,
                          hint: "lastname_place_holder".tr(),
                          suffixIcon: Icons.person,
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
                          title: "cin".tr(),
                          textController: cubit.cin,
                          type: TextInputType.streetAddress,
                          hint: "cin_place_holder".tr(),
                          suffixIcon: Icons.password,
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
                        Container(
                            margin: EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "user_type".tr(),
                                  style: GoogleFonts.josefinSans(
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
                                  padding: EdgeInsets.only(left: 14.0),
                                  height: 52,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(
                                            value: cubit.selected,
                                            hint: Text(
                                              "user_type_place_holder".tr(),
                                              style: subTitleTextStle,
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey,
                                            ),
                                            iconSize: 32,
                                            elevation: 4,
                                            style: subTitleTextStle,
                                            underline: Container(height: 0),
                                            onChanged: (newValue) {
                                              cubit.selected = newValue!;
                                              cubit.changeSelected();
                                              cubit.user_type.text = newValue;
                                            },
                                            items: cubit.type
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value.toString(),
                                                child: Text(value.toString()),
                                              );
                                            }).toList()),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
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
                                            lastname:cubit.lastname.text,
                                            cin:cubit.cin.text
                                          ),
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
