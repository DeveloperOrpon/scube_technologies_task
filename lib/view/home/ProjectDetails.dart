import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scube_technologies_task/modes/proejctModel.dart';
import 'package:scube_technologies_task/view/home/addProjectScreen.dart';

import '../../widgets/userSmallTile.dart';

class ProjectDetails extends StatelessWidget {
  final ProjectModel projectModel;

  const ProjectDetails({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
            elevation: 0,
            toolbarHeight: 70,
            pinned: true,
            floating: false,
            backgroundColor: Color(0xFF131232),
            leadingWidth: 80,
            leading: CircleAvatar(
              backgroundColor: Color(0xFF282747),
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            actions:  [
              InkWell(
                onTap: () {
                  Get.to(const AddProjectScreen(),transition: Transition.fadeIn);
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF282747),
                  radius: 50,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFF131232),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        '${projectModel.projectName}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,

                          color: Colors.white,
                          // letterSpacing: 1.3
                        ),
                      ),
                      // Text(
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   '${projectModel.projectUpdate}',
                      //   style: GoogleFonts.roboto(
                      //     fontWeight: FontWeight.w200,
                      //     fontSize: 14,
                      //     color: Colors.white,
                      //
                      //     // letterSpacing: 1.3
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatusChip(
                                color: Colors.red,
                                title: 'Engineer',
                                name: '${projectModel.assignedEngineer}',
                              ),
                            ),
                            Expanded(
                              child: StatusChip(
                                color: Colors.green,
                                title: 'Technician',
                                name: '${projectModel.assignedTechnician}',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Start Date',
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                            "${DateFormat.yMMMMd().format(DateTime.parse(projectModel.startDate.toString()))}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'End Date',
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                            "${DateFormat.yMMMMd().format(DateTime.parse(projectModel.endDate.toString()))}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Project Update",
                    style: GoogleFonts.roboto(

                      fontSize: 16,
                      color: Colors.black,
                      // letterSpacing: 1.3
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    '${projectModel.projectUpdate}',
                    style: GoogleFonts.roboto(

                      fontSize: 14,
                      color: Colors.black54,

                      // letterSpacing: 1.3
                    ),
                  ),
                ),
              ],
            )
          ]))
        ],
      ),
    );
  }
}
