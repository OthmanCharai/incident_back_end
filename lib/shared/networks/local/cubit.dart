import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/models/Incident.dart';
import 'package:incidence_front/models/Inscription.dart';
import 'package:incidence_front/modules/home/home.dart';
import 'package:incidence_front/modules/home/screeans/account.dart';
import 'package:incidence_front/modules/home/screeans/home_screan.dart';
import 'package:incidence_front/modules/home/screeans/incident_screans.dart';
import 'package:incidence_front/modules/incident/add_client.dart';
import 'package:incidence_front/modules/incident/add_document.dart';
import 'package:incidence_front/modules/incident/add_localisation.dart';
import 'package:incidence_front/modules/incident/add_note.dart';
import 'package:incidence_front/modules/incident/add_video.dart';
import 'package:incidence_front/modules/logUp/sign_up.dart';
import 'package:incidence_front/modules/login/sing_in.dart';
import 'package:incidence_front/modules/page/onboarding_page.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import 'dart:io';

String path = "/storage/";

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
  TextEditingController society_ville = TextEditingController();
  TextEditingController ice = TextEditingController();
  TextEditingController society_gerant = TextEditingController();
  TextEditingController rip = TextEditingController();
  TextEditingController society_gsm = TextEditingController();
  TextEditingController localisation_agence = TextEditingController();
  TextEditingController localisation_ville = TextEditingController();
  TextEditingController localisation_tele_1 = TextEditingController();
  TextEditingController localisation_tele_2 = TextEditingController();
  TextEditingController localisation_tele_3 = TextEditingController();
  TextEditingController voiture = TextEditingController();
  TextEditingController matricule = TextEditingController();
  TextEditingController couleur = TextEditingController();
  TextEditingController cheque = TextEditingController();
  TextEditingController inc_type = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController searsh = TextEditingController();
  VideoPlayerController controller = new VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScrean(),
    IncidenceScrean(),
    AccountScrean(),
  ];

  static String bear = "";
  static Inscription? auth;
  static String user_id = '';
  static String localisation_id = "";
  static String document_id = "";
  static String note_id = "";
  static String type_id = '';
  static String video_id = '';
  static bool index = false;
  File? compressed;
  Record audioRecorder = Record();

  String a = "vol";
  bool isSelected = false;
  List<Incident> incidentList = [];
  List<Incident> incidentCompanyList = [];

  static List<String> incident_type = [];

  PickedFile? file;
  PickedFile? cin_photo;
  PickedFile? photo;
  String audio_path = '/assets/audio/';

  static AppCubit get(context) => BlocProvider.of(context);
  bool isPasswword = true;
  String selected = 'Client Particulier';

  bool isBottomSheetOpen = false;
  IconData floatingButtomIcon = Icons.language;

  void startRecording() async {
    await Record.start(path: audio_path);
  }

  void stopRecording() async {
    Record.stop().then((value) {
      print(audio_path);
    });
    emit(RecordStopped());
    print('Output path $audio_path');
  }

  void selectedIndexChange() {
    emit(ChangeCurrentIndex());
  }

  void searcheChanged() {
    emit(SearchCahnge());
  }

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

  void initialiseVideo({
    required String path,
  }) {
    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        emit(InitialiseVideo());
      })
      ..play();
  }

  chooseImage() async {
    file = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    setStatus('');
  }

  takeImage() async {
    file = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    setStatus('');
  }

  chooseVideo() async {
    file = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    File myfile = File(file!.path);
    controller = VideoPlayerController.file(myfile)
      ..initialize().then((_) {
        emit(InitialiseVideo());
      })
      ..play();
    //vdoCompress(vdoPath: file!.path, videoFile: file);

    emit(ShowMessage());

    setStatus('');
  }

  takeVideo() async {
    file = await ImagePicker().getVideo(
      source: ImageSource.camera,
    );
    File myfile = File(file!.path);
    controller = VideoPlayerController.file(myfile)
      ..initialize().then((_) {
        emit(InitialiseVideo());
      })
      ..play();
    // vdoCompress(vdoPath: file!.path, videoFile: file);
    emit(ShowMessage());

    setStatus('');
  }

  chooseImageCin() async {
    cin_photo = await ImagePicker().getImage(source: ImageSource.gallery);

    setStatus('');
  }

  takeImageCin() async {
    cin_photo = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    setStatus('');
  }

  chooseImagePers() async {
    photo = await ImagePicker().getImage(source: ImageSource.gallery);

    setStatus('');
  }

  takeImagePers() async {
    photo = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    setStatus('');
  }

  setStatus(String message) {
    emit(ShowMessage());
  }

  void createDocument({
    required BuildContext context,
  }) async {
    String fileName = file!.path.split('/').last;
    String cinName = cin_photo!.path.split('/').last;
    String photoName = photo!.path.split('/').last;

    var data = FormData.fromMap({
      "photo_cheque": await MultipartFile.fromFile(
        file!.path,
        filename: fileName,
      ),
      "photo_cin": await MultipartFile.fromFile(
        cin_photo!.path,
        filename: cinName,
      ),
      "photo": await MultipartFile.fromFile(
        photo!.path,
        filename: photoName,
      ),
      "cheque": cheque.text,
      "user_id": user_id,
    });
    print(data.files[0].value.filename);
    AppDio.createDocument(url: "api/v1/document", info: data, token: bear)
        .then((value) {
      document_id = value.data[0]['id'].toString();
      //print(value.data[0]['id']);
      Fluttertoast.showToast(
          msg: lang == "Fr"
              ? "les document sont été enregistrer"
              : "تم حفظ المستندات",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddLocalisation()));
      print(value);
    }).catchError((onError) {
      print(onError);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void createVideo({
    required BuildContext context,
  }) async {
    print("hahaha $file");
    String fileName = file!.path.split('/').last;
    var data = FormData.fromMap({
      "path": await MultipartFile.fromFile(
        file!.path,
        filename: fileName,
      ),
      "user_id": user_id,
    });
    print(data.files[0].value.filename);
    AppDio.createDocument(url: "api/v1/video", info: data, token: bear)
        .then((value) {
      video_id = value.data.toString();
      print("okkkk");
      print(value.data);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "le video a été enregistrer" : "تم تسجيل الفيديو",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      createIncident(context: context);
      print("hahahahahh$value");
    }).catchError((onError) {
      print(onError);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
  /*  void createAudio({
    required BuildContext context,
    required File file,
  }) async {
    print("hahaha $file");
    String fileName = file.path.split('/').last;
    var data = FormData.fromMap({
      "path": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "user_id": user_id,
    });
    print(data.files[0].value.filename);
    AppDio.createDocument(url: "api/v1/video", info: data, token: bear)
        .then((value) {
      //video_id = value.data[0]['id'].toString();
      print(value.data[0]);
      Fluttertoast.showToast(
          msg: lang == "Fr"
              ? "les document sont été enregistrer"
              : "تم حفظ المستندات",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddLocalisation()));
      print(value);
    }).catchError((onError) {
      print(onError);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
 */

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
      auth = value;
      bear = token;
      print(bear);
      //Navigator.pushNamed(context, SignUp.routeName);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((onError) {
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
    AppDio.postData(
            url: "api/v1/client",
            info: {
              "firstname": firstname.text,
              "lastname": lastname.text,
              "cin": cin.text
            },
            token: bear)
        .then((value) {
      user_id = value.data[0]['id'].toString();
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
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void createSociety({
    required BuildContext context,
  }) {
    AppDio.postData(
            url: "api/v1/society",
            info: {
              "firstname": firstname.text,
              "lastname": lastname.text,
              "cin": cin.text,
              "nom": firstname.text,
              "ville": society_ville.text,
              "ice": ice.text,
              "gerant": society_gerant.text,
              "rip": rip.text,
              "gsm": society_gsm.text
            },
            token: bear)
        .then((value) {
      user_id = value.data[0]['id'].toString();
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
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void createLocalisation({
    required BuildContext context,
  }) {
    AppDio.postData(
            url: "api/v1/localisation",
            info: {
              "agence": localisation_agence.text,
              "ville": localisation_ville.text,
              "tele_1": localisation_tele_1.text,
              "tele_2": localisation_tele_2.text,
              "tele_3": localisation_tele_3.text,
              "voiture": voiture.text,
              "matricule": matricule.text,
              "couleur": couleur.text
            },
            token: bear)
        .then((value) {
      localisation_id = value.data['id'].toString();
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "le client a été ajouter" : " تمت إضافة العمي",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddNote()));
    }).catchError((onError) {
      print(onError);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void changeState() {
    emit(UploadsImages());
  }

  void getAllType() {
    AppDio.getAllType(url: "api/v1/type", token: bear).then((value) {
      value.forEach((element) {
        incident_type.add(element.name);
      });
      a = incident_type.first;
    });
  }

  void createNote({
    required BuildContext context,
  }) {
    AppDio.postData(
            url: "api/v1/note",
            info: {
              "content": note.text,
              "user_id": user_id,
            },
            token: bear)
        .then((value) {
      print(value.data['id']);
      note_id = value.data['id'].toString();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    AppDio.postData(
            url: "api/v1/type",
            info: {
              "name": inc_type.text,
              "user_id": user_id,
            },
            token: bear)
        .then((value) {
      type_id = value.data['id'].toString();
      print(value.data);
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "la note a été ajouter" : "  تمت إضافة الملاحظة ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddVideo()));
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: lang == "Fr" ? "Veuillez réessayer" : "يرجى المحاولة مرة أخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void getAllIncidents() {
    AppDio.getAllIncidenct(url: "api/v1/incident", token: bear).then((value) {
      incidentList = value;
      print(value);
      emit(LoadData());
    }).catchError((onError) {
      print(onError);
    });
  }

  void showToast({
    required String name,
  }) {
    Fluttertoast.showToast(
        msg: lang == "Fr"
            ? "il y a pas d incidence de type $name"
            : "لا توجد حالات من هذا النوع $name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void getAllCompanyIncident() {
    AppDio.getAllIncidenct(
            url: "api/v1/user/incident/${auth!.data.id}", token: bear)
        .then((value) {
      incidentCompanyList = value;
      print("hahahaha");
      print(incidentCompanyList);
    }).catchError((onError) {
      print(onError);
    });
  }

  void logout({
    required BuildContext context,
  }) {
    final storage = new FlutterSecureStorage();
    storage.read(key: "token").then((value) {
      print(value.toString());
      AppDio.logout(url: "api/v1/delete", token: value.toString())
          .then((value) {
        storage.delete(key: "token").then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        });
      }).catchError((error) {
        print(error);
      });
    });
  }

  void createIncident({required BuildContext context}) {
    AppDio.postData(
            url: "api/v1/incident",
            info: {
              'user_id': user_id,
              "document_id": document_id,
              "note_id": note_id,
              "audio_id": 1,
              "video_id": video_id,
              "type_id": type_id,
              "localisation_id": localisation_id,
              "inscription_id": auth!.data.id,
            },
            token: bear)
        .then((value) {
      print("ok mn incident");
      print("hahahahahahahahahah $value");
      getAllIncidents();
      /* Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) => Home())); */
    }).catchError((onError) {
      print(onError);
    });
  }
}
