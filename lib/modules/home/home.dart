import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/home/cart.dart';
import 'package:incidence_front/modules/incident/add_client.dart';
import 'package:incidence_front/shared/components/button.dart';
import 'package:incidence_front/shared/components/size.dart';
import 'package:incidence_front/shared/components/taskTitle.dart';
import 'package:incidence_front/shared/components/widget.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:get/get.dart';
import 'package:incidence_front/shared/styles/theme_service.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<String> taskList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getAllType()
        ..getAllIncidents()
        ..getAllCompanyIncident(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          context.watch<LanguageController>();
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryClr,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddIncident(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: primaryClr.withOpacity(1.0)),
                    label: "Pointage"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list, color: primaryClr.withOpacity(1.0)),
                    label: "Incident"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box,
                        color: primaryClr.withOpacity(1.0)),
                    label: "Compte"),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.currentIndex = index;
                cubit.selectedIndexChange();
              },
            ),
          );
        },
      ),
    );
  }
}
