import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/models/Incident.dart';
import 'package:incidence_front/modules/home/cart.dart';
import 'package:incidence_front/modules/home/iconButton.dart';
import 'package:incidence_front/shared/components/widget.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:incidence_front/shared/styles/theme.dart';

class IncidenceScrean extends StatelessWidget {
  IncidenceScrean({Key? key}) : super(key: key);
  List<Incident> incidentListSearch = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        context.watch<LanguageController>();
        return Padding(
          padding: EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                    child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      search(
                        textEditingController: cubit.searsh,
                        onChanged: (value) {
                          TextSelection previousSelection =
                              cubit.searsh.selection;
                          cubit.searsh.text = value;
                          cubit.searsh.selection = previousSelection;

                          incidentListSearch = cubit.incidentCompanyList
                              .where((element) => element.user.cin
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          cubit.searcheChanged();
                        },
                        label: "search".tr(),
                      ),
                      IconBtnWithCounter(
                        svgSrc: "assets/images/Bell.svg",
                        numOfitem: 3,
                        press: () {},
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: 20.0,
                ),
                ConditionalBuilder(
                  condition: cubit.incidentCompanyList.length>0,
                  builder: (context) =>
                     Container(
                    height: 30.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => categories(
                                  text: AppCubit.incident_type[index],
                                  onTap: () {
                                    incidentListSearch = cubit
                                        .incidentCompanyList
                                        .where((element) => element.type.name
                                            .toLowerCase()
                                            .contains(AppCubit.incident_type[index]
                                                .toLowerCase()))
                                        .toList();
                                    if (incidentListSearch.length == 0) {
                                      cubit.showToast(
                                          name: AppCubit.incident_type[index]);
                                    }
                                    cubit.searcheChanged();
                                  },
                                  isSelected: true),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10.0,
                                  ),
                              itemCount: AppCubit.incident_type.length),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) =>
                      Center(child:Text(
                            "no_incident".tr(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gothicA1(
                              textStyle: TextStyle(
                                color: primaryClr,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                              ),
                            ),
                          )),
                ),
                Container(
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => cart(
                          name: cubit.searsh.text.isEmpty
                              ? "${cubit.incidentCompanyList[index].user.firstname} ${cubit.incidentCompanyList[index].user.lastname}"
                              : "${incidentListSearch[index].user.firstname} ${incidentListSearch[index].user.lastname}",
                          cin: cubit.searsh.text.isEmpty
                              ? cubit.incidentCompanyList[index].user.cin
                              : incidentListSearch[index].user.cin,
                          incident_date: cubit.searsh.text.isEmpty
                              ? cubit.incidentCompanyList[index].createdAt
                                  .toString()
                              : incidentListSearch[index].createdAt.toString(),
                          incident: cubit.searsh.text.isEmpty
                              ? cubit.incidentCompanyList[index].type.name
                              : incidentListSearch[index].type.name,
                          note: cubit.searsh.text.isEmpty
                              ? cubit.incidentCompanyList[index].note.content
                              : incidentListSearch[index].note.content,
                          onTap: () {},
                          path: cubit.searsh.text.isEmpty
                              ? cubit.incidentCompanyList[index].document.photo
                                  .replaceAll("localhost", "192.168.0.144:8000")
                              : incidentListSearch[index]
                                  .document
                                  .photo
                                  .replaceAll(
                                      "localhost", "192.168.0.144:8000")),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                      itemCount: cubit.searsh.text.isNotEmpty
                          ? incidentListSearch.length
                          : cubit.incidentCompanyList.length),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
