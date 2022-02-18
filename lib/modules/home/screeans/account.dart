import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:incidence_front/modules/home/screeans/profile.dart';
import 'package:incidence_front/shared/networks/local/appState.dart';
import 'package:incidence_front/shared/networks/local/cubit.dart';
import 'package:incidence_front/shared/networks/remote/constante.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

/* class AccountScrean extends StatelessWidget {
  const AccountScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */

class AccountScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: kSpacingUnit.w * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: kSpacingUnit.w * 3),
             
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: kSpacingUnit.w * 10,
                          width: kSpacingUnit.w * 10,
                          margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                radius: kSpacingUnit.w * 5,
                                backgroundImage:
                                    AssetImage('assets/images/a1.png'),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: kSpacingUnit.w * 2.5,
                                  width: kSpacingUnit.w * 2.5,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    heightFactor: kSpacingUnit.w * 1.5,
                                    widthFactor: kSpacingUnit.w * 1.5,
                                    child: Icon(LineAwesomeIcons.pen,
                                        color: kDarkPrimaryColor,
                                        size: ScreenUtil()
                                            .setSp(kSpacingUnit.w * 1.5)
                                            .toDouble()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: kSpacingUnit.w * 2),
                        Text(
                          AppCubit.auth!.data.agence,
                          style: kCaptionTextStyle,
                        ),
                        SizedBox(height: kSpacingUnit.w * 0.5),
                        Text(
                           AppCubit.auth!.data.email,
                          style: kCaptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: kSpacingUnit.w * 3),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ProfileListItem(
                      icon: LineAwesomeIcons.user,
                      text:AppCubit.auth!.data.agence ,
                      hasNavigation: false,

                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.city,
                      text: AppCubit.auth!.data.ville,
                      hasNavigation: false,

                      
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.map_marked,
                      text: AppCubit.auth!.data.address,
                      hasNavigation: false,

                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.person_entering_booth,
                      text:AppCubit.auth!.data.gerant ,
                      hasNavigation: false,

                    ),

                    GestureDetector(
                      onTap:(){
                      cubit.logout(context: context);

                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        hasNavigation: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
