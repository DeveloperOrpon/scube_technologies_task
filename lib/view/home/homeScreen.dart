import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_technologies_task/controller/projectController.dart';
import 'package:scube_technologies_task/view/home/addProjectScreen.dart';
import 'package:scube_technologies_task/widgets/projectTile.dart';
import 'package:scube_technologies_task/widgets/userSmallTile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectController = Get.put(ProjectController());
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarIconBrightness: Brightness.light,
    //   statusBarColor: Color(0xFF131232),
    // ));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 1,
        elevation: 0,
        backgroundColor:Color(0xFF131232),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Color(0xFF131232),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
            return  CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 70,
                  pinned: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: Color(0xFF131232),
                  ),
                  floating: false,
                  backgroundColor: Color(0xFF131232),
                  leadingWidth: 80,
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ,Orpon",
                        style: GoogleFonts.aBeeZee(
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text("Let's finish your tasks",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Get.to(const AddProjectScreen(),transition: Transition.fadeIn );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF282747),
                        radius: 50,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(200),
                      child: Container(
                        alignment: Alignment.topCenter,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF131232),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              child: Text(
                                "September 2024",
                                style: GoogleFonts.aBeeZee(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: EasyDateTimeLine(
                                initialDate: DateTime.now(),
                                onDateChange: (selectedDate) {
                                  //`selectedDate` the new date selected.
                                },
                                headerProps: const EasyHeaderProps(
                                    monthPickerType: MonthPickerType.switcher,
                                    dateFormatter: DateFormatter.fullDateDMY(),
                                    monthStyle: TextStyle(color: Colors.white),
                                    selectedDateStyle:
                                        TextStyle(color: Colors.white),
                                    showHeader: false),
                                dayProps: const EasyDayProps(
                                  dayStructure: DayStructure.dayStrDayNum,
                                  height: 80,
                                  width: 65,
                                  inactiveDayStyle: DayStyle(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        color: Color(0xFF282747),
                                      ),
                                      dayStrStyle: TextStyle(color: Colors.white),
                                      dayNumStyle: TextStyle(color: Colors.white)),
                                  activeDayStyle: DayStyle(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color(0xff5f37ef),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 60,
                              width: Get.width,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 7),
                                child: Text(
                                  "Ongoing Project",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                    // letterSpacing: 1.3
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                projectController.availableList.value.isEmpty?SliverList(delegate: SliverChildListDelegate([
                   const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: SpinKitThreeBounce(
                      color:  Color(0xff5f37ef),
                      size: 30,
                    ),
                  )
                ])): SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => ProjectTile(
                            projectModel:
                                projectController.availableList.value[index]),
                        childCount: projectController.availableList.value.length))
              ],
            );
          }
        ),
      ),
    );
  }
}
