import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:incidence_front/shared/networks/remote/constante.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

   ProfileListItem({
     Key?key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 8,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 4,
      ).copyWith(
        bottom: kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: kSpacingUnit.w * 1.5),
          Text(
            this.text,
            style: kCaptionTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: kSpacingUnit.w * 2.5,
            ),
        ],
      ),
    );
  }
}
