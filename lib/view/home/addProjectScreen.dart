import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:scube_technologies_task/controller/projectController.dart';
import 'package:scube_technologies_task/service/DatePicker/customDatePicker.dart';
import 'package:scube_technologies_task/service/helper/helper.dart';

import '../../core/config/customStyle.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectController = Get.put(ProjectController());
    if (projectController.endDate.value != null ||
        projectController.startDate.value != null) {
      projectController.endDate.value = null;
      projectController.startDate.value = null;
    }
    return Scaffold(
        backgroundColor: Color(0xFF131232),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: FormBuilder(
            key: projectController.addProjectFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 60),
                Image.asset(
                  'assets/logo/logo.png',
                  height: 120,
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7),
                  child: FormBuilderTextField(
                    name: 'project_name',
                    decoration: decoration(
                        title: 'Project Name',
                        context: context,
                        iconData: CupertinoIcons.profile_circled),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    autofillHints: const [AutofillHints.email],
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7),
                  child: FormBuilderTextField(
                    // obscureText: true,
                    name: 'project_update',
                    decoration: decoration(
                        title: 'Project Update',
                        context: context,
                        iconData: Icons.browser_updated),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    autofillHints: const [AutofillHints.email],
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7),
                  child: FormBuilderTextField(
                    // obscureText: true,
                    name: 'assigned_engineer',
                    decoration: decoration(
                        title: 'Assigned Engineer',
                        context: context,
                        iconData: Icons.engineering,
                        hideText: false),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    autofillHints: const [AutofillHints.email],
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7),
                  child: FormBuilderTextField(
                    // obscureText: true,
                    name: 'assigned_technician',
                    decoration: decoration(
                        title: 'Assigned Technician',
                        context: context,
                        iconData: Icons.military_tech,
                        hideText: false),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    autofillHints: const [AutofillHints.email],
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => showSingleDatePicker(
                                context,
                                projectController.startDate.value == null
                                    ? 'Start Date'
                                    : formatDateTime(
                                            projectController.startDate.value!)
                                        .toString(), (value) {
                              log("value: ${value}");
                              projectController.startDate.value = value;
                            })),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() => showSingleDatePicker(
                                context,
                                projectController.endDate.value == null
                                    ? 'End Date'
                                    : formatDateTime(
                                            projectController.endDate.value!)
                                        .toString(), (value) {
                              projectController.endDate.value = value;
                            })),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  color: Color(0xff5f37ef),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  onPressed: () async {
                    if (projectController.addProjectFormKey.currentState
                            ?.saveAndValidate() ??
                        false) {
                      if (true) {
                        if (projectController.endDate.value == null ||
                            projectController.startDate.value == null) {
                          showErrorToast(
                              'Warning',
                              'Project Start Date & End Date Required',
                              context);
                          return;
                        }
                        if (projectController.endDate.value!.compareTo(
                                projectController.startDate.value!) ==
                            -1) {
                          showErrorToast('Warning',
                              'Project Start Date & End Date Invalid', context);
                          return;
                        }
                        log("Value: ${projectController.addProjectFormKey.currentState?.value}");
                        startLoading();
                        String? value=await projectController.addProject(projectController
                            .addProjectFormKey.currentState!.value!);
                        Get.back();

                        if (value!=null) {
                          showSuccessToastTop('Information',
                              '$value', context);

                        } else {
                          showErrorToast(
                              'Waring', 'Server is invalid', context);
                        }
                       await projectController.getAllProject();
                      }
                    }
                    debugPrint(projectController
                        .addProjectFormKey.currentState?.value
                        .toString());
                  },
                  child: Text(
                    'Login'.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'robotoMono'),
                  ),
                ),
              ],
            ),
          ),
        ));
    ;
  }
}
