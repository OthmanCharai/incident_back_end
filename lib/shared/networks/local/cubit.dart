import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:incidence_front/modules/login/sing_in.dart';
import 'package:incidence_front/modules/page/onboarding_page.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/dio.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());

  String lang = "Fr";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController agence = TextEditingController();
  TextEditingController ville = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gerant = TextEditingController();
  TextEditingController gsm_1 = TextEditingController();
  TextEditingController gsm_2 = TextEditingController();
  TextEditingController gsm_3 = TextEditingController();
  TextEditingController fix = TextEditingController();
  TextEditingController phone = TextEditingController();

  static AppCubit get(context) => BlocProvider.of(context);
  bool isPasswword = true;

  bool isBottomSheetOpen = false;
  IconData floatingButtomIcon = Icons.language;

  void showPassword() {
    isPasswword = !isPasswword;
    emit(ShowPassword());
  }

  void changeBottomNavigationSheets(bool isShow, IconData icons) {
    isBottomSheetOpen = isShow;
    floatingButtomIcon = icons;
  }

  void changeLangague({required String lang}) {
    this.lang = lang;
    emit(ChangeLangagueState());
  }

  void login({
    required BuildContext context,
  }) async {
    AppDio.userLogin(url: "api/v1/login", info: {
      "email": email.text,
      "password": password.text,
      "device_name": "pc",
    }).then((value) {
      print("hahahahahowa");
      print(value.data['token']);
      tryToken(token: value.data['token'], context: context);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: "Enter a valide User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 16.0);
      emit(InvalideUser());
    });
  }

  void tryToken({
    required String? token,
    required BuildContext context,
  }) async {
    print("THIS IS THE TOKEN${token}");
    print(token == null);
    if (token == null) {
      print("token is invalide ");
      return;
    }
    print("hada howa token ${token}");
    AppDio.getUser(url: "api/v1/user", token: token).then((value) {
/*       if (value.data['created_at'] == null) {
        Fluttertoast.showToast(
            msg: "please try to verifie your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[800],
            textColor: Colors.white,
            fontSize: 16.0);
        emit(VerifyEmail());
        return; 
      }
        
        */
      this.storeToken(token: token);
      print(value);
      //Navigator.pushNamed(context, SignIn.routeName);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: "Some Think was wrang please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoadingState());
    });
  }

  /*
  // Store Token
  */
  void storeToken({required String token}) async {
    /* final storage = new FlutterSecureStorage();
    if (token != "") {
      await storage.write(key: "token", value: token);
    } */
  }

  /*
  // Read Token
  */
  void readToken({
    required BuildContext context,
  }) async {
 /*    final storage = new FlutterSecureStorage();
    storage.read(key: "token").then((value) {
      print("hhhhhhh the old token${value.toString()}");
      tryToken(token: value, context: context);
    }); */
  }

  /*
  // Register Function
  */
  Future register({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    AppDio.register(url: "api/v1/register", info: {
      "email": email,
      "name": name,
      "password": password,
      "phone": "a",
      "image": "a",
    }).then((value) {
      print(value);
      AppDio.sendVerificationEmail(
        url: "api/v1/email/verify",
        token: value.data['token'].toString(),
      ).then((value) {
        Fluttertoast.showToast(
            msg:
                "You have register with success virify your email address please",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
      Navigator.pushNamed(context, SignIn.routeName);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Some Think was wrang please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print(error);
    });
  }

}
