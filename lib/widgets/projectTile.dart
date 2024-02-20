import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_technologies_task/controller/projectController.dart';
import 'package:scube_technologies_task/modes/proejctModel.dart';
import 'package:scube_technologies_task/view/home/ProjectDetails.dart';
import 'package:scube_technologies_task/widgets/userSmallTile.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;

  const ProjectTile({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProjectDetails(projectModel: projectModel),transition: Transition.rightToLeft);
      },
      child: Container(
        height: 165,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '#${projectModel.id}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '2 days Left',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${projectModel.duration}days long',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
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
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              '${projectModel.projectUpdate}',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w200,
                fontSize: 14,
                color: Colors.white,

                // letterSpacing: 1.3
              ),
            ),
            Spacer(),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
