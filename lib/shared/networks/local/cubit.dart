import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/models/Inscription.dart';
import 'package:incidence_front/modules/incident/add_client.dart';
import 'package:incidence_front/modules/incident/add_document.dart';
import 'package:incidence_front/modules/logUp/sign_up.dart';
import 'package:incidence_front/modules/login/sing_in.dart';
import 'package:incidence_front/modules/page/onboarding_page.dart';
import 'package:incidence_front/modules/widget/home.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/dio.dart';
import 'package:easy_localization/easy_localization.dart';

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
  TextEditingController user_type = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController cin = TextEditingController();

  static var auth = "";
  static String user_id = '';
  static String bear = "";

  static AppCubit get(context) => BlocProvider.of(context);
  bool isPasswword = true;
  String selected = 'Client Particulier';

  bool isBottomSheetOpen = false;
  IconData floatingButtomIcon = Icons.language;

  void showPassword() {
    isPasswword = !isPasswword;
    emit(ShowPassword());
  }

  void changeSelected() {
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

  List<String> type = [
    'Client Particulier',
    "Client Societe",
  ];

  void login({
    required BuildContext context,
  }) async {
    print("hahah ${email.text}");
    print("hahah ${password.text}");
    AppDio.userLogin(url: "api/v1/login", info: {
      "email": email.text,
      "password": password.text,
      "device_name": "pc",
    }).then((value) {
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
    AppDio.getUser(url: "api/v1/agence", token: token).then((value) {
      print(value);
      if (value.data.emailVerifiedAt == null) {
        Fluttertoast.showToast(
            msg: this.lang == "Fr"
                ? "S'il vous plaît essayez de vérifier votre e-mail"
                : "يرجى محاولة التحقق من بريدك الإلكتروني",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(VerifyEmail());
        return;
      }
      this.storeToken(token: token);
      print(token);
      bear = token;
      print("ha ana tani ");
      print(bear);
      //Navigator.pushNamed(context, SignUp.routeName);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddIncident()));
    }).catchError((onError) {
      print("hahaha");
      print(onError);
      Fluttertoast.showToast(
          msg: this.lang == "Fr"
              ? "Veuillez réessayer"
              : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
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
    final storage = new FlutterSecureStorage();
    if (token != "") {
      await storage.write(key: "token", value: token);
    }
  }

  /*
  // Read Token
  */
  void readToken({
    required BuildContext context,
  }) async {
    final storage = new FlutterSecureStorage();
    storage.read(key: "token").then((value) {
      print("hhhhhhh the old token${value.toString()}");
      tryToken(token: value, context: context);
    });
  }

  /*
  // Register Function
  */
  void register({
    required BuildContext context,
  }) {
    AppDio.register(url: "api/v1/register", info: {
      "agence": agence.text,
      "ville": ville.text,
      "address": address.text,
      "gerant": gerant.text,
      "gsm_1": gsm_1.text,
      "gsm_2": gsm_2.text,
      "gsm_3": gsm_3.text,
      "fix": fix.text,
      "phone": phone.text,
      "email": email.text,
      "password": password.text,
    }).then((value) {
      print(value);
      AppDio.sendVerificationEmail(
        url: "api/v1/email/verify",
        token: value.toString(),
      ).then((value) {
        Fluttertoast.showToast(
            msg: lang == "Fr"
                ? "Vous vous êtes inscrit avec succès, veuillez vérifier votre adresse e-mail s'il vous plaît"
                : "لقد قمت بالتسجيل بنجاح تحقق من عنوان بريدك الإلكتروني من فضلك",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      });
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print(error);
    });
  }

  void createClient({
    required BuildContext context,
  }) {
    print("ha ana");
    print("ha ana $bear");

    AppDio.postData(
            url: "api/v1/client",
            info: {
              "firstname": firstname.text,
              "lastname": lastname.text,
              "cin": cin.text
            },
            token: bear)
        .then((value) {
      user_id = value.data['id'].toString();
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "le client a été ajouter" : " تمت إضافة العمي",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddDocument()));
    }).catchError((onError) {
      print(onError);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
