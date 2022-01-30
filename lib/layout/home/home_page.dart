/* import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incidence_front/models/Agence.dart';
import 'package:incidence_front/shared/components/button.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:incidence_front/shared/styles/theme_service.dart';
import "components/components.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context: context),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _dateBar(onTap: (date){

          }),
          SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }
}

_appBar({
  required BuildContext context,
}) {
  return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          /*     notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Light theme activated."
                  : "Dark theme activated",
            ); */

          //notifyHelper.scheduledNotification();
          //notifyHelper.periodicalyNotification();
        },
        child: Icon(
            Get.isDarkMode ? FlutterIcons.sun_fea : FlutterIcons.moon_fea,
            color: Get.isDarkMode ? Colors.white : darkGreyClr),
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

_addTaskBar() {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingTextStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Today",
              style: headingTextStyle,
            ),
          ],
        ),
        MyButton(
          label: "+ Add Task",
          onTap: () {},
        ),
      ],
    ),
  );
}



_dateBar({
  required Function(DateTime)? onTap,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10, left: 20),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: DatePicker(
        DateTime.now(),
        height: 100.0,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        //selectedTextColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
          ),
        ),
        onDateChange: onTap,
      ),
    ),
  );
}

_showTasks() {
    return Expanded(
      child: Obx(() {
        /* if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else */
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                Task task = new Task(id: 1, title: "title", note: "note", isCompleted: 1, date: "date", startTime: "startTime", endTime: "endTime", color: 1, remind: 1, repeat: "repeat");
                if (task.repeat == 'Daily') {

                  var hour= task.startTime.toString().split(":")[0];
                  var minutes = task.startTime.toString().split(":")[1];
                  debugPrint("My time is "+hour);
                  debugPrint("My minute is "+minutes);
                  DateTime date= DateFormat.jm().parse(task.startTime);
                  var myTime = DateFormat("HH:mm").format(date);
                  /* notifyHelper.scheduledNotification(int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]), task); */

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (task.date == DateFormat.yMd().format(DateTime.now())) {
                  //notifyHelper.scheduledNotification();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {

                                 // showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
      }),
    );
  }









































 */