import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/logUp/sign_up.dart';
import 'package:incidence_front/shared/components/input.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var second = GlobalKey<FormState>();
    static String routeName = "/sign_in";


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..readToken( context: context),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          LanguageController controller = context.read<LanguageController>();
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Themes.light.backgroundColor,
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
                          height: 150.0,
                        ),
                        Center(
                          child: Text(
                            "login_welcome".tr(),
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
                            cubit.login(
                                  context: context,
                                );
                          }
                        }),
                        SizedBox(
                          height: 30.0,
                        ),
                        _signUpLabel("login_no_account_yet".tr(),
                            const Color(0xff909090)),
                        const SizedBox(
                          height: 10,
                        ),
                        _signupButton("login_register_btn".tr(), primaryClr,(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        }),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryClr,
              onPressed: () {
                if (cubit.isBottomSheetOpen) {
                  cubit.isBottomSheetOpen = false;
                  Navigator.pop(context);

                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Form(
                          key: second,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.changeLangague(lang: "Ar");
                                      print(cubit.lang);
                                      context.locale = Locale('ar', 'MA');
                                      controller.onLanguageChanged();
                                    },
                                    child: Text(
                                      "Ar".tr(),
                                      style: GoogleFonts.gothicA1(
                                        textStyle: TextStyle(
                                          color: Color(0xff909090),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.changeLangague(lang: "Fr");
                                      context.locale = Locale('fr', 'FR');
                                      controller.onLanguageChanged();
                                      print(cubit.lang);
                                    },
                                    child: Text(
                                      "Fr".tr(),
                                      style: GoogleFonts.gothicA1(
                                        textStyle: TextStyle(
                                          color: Color(0xff909090),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomNavigationSheets(false, Icons.language);
                  });

                  cubit.changeBottomNavigationSheets(true, Icons.language);
                }
              },
              child: Icon(
                cubit.floatingButtomIcon,
                color: Colors.white,
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
        actions: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage("images/girl.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
        ]);
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

    Widget _signupButton(String label, Color textColor,Function()?onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
      ),
    );
  }
}
