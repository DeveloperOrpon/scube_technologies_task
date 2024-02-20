import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../modes/proejctModel.dart';
import '../service/ApiRoute.dart';
import '../service/DatePicker/customDatePicker.dart';
import '../service/interceptors/ConnectivityRequestRetrier.dart';
import '../service/interceptors/RetryOnConnectionChangeIntercptor.dart';

class ProjectController extends GetxController {
  late DIO.Dio dio;
  RxList<ProjectModel> availableList = RxList<ProjectModel>([]);
  final addProjectFormKey = GlobalKey<FormBuilderState>();
  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();

  @override
  onInit() {
    DIO.BaseOptions options = DIO.BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2));
    dio = DIO.Dio(options);
    // _dio.interceptors.add(RetryInterceptor(dio: _dio));
    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier:
            ConnectiveRequestRetrier(connectivity: Connectivity(), dio: dio)));
    super.onInit();
    getAllProject();

    ///init value
  }

  Future<bool> getAllProject() async {
    const projectUrl = PROJECT_URL;
    try {
      final DIO.Response response = await dio.get(projectUrl);
      log('${response.data.runtimeType}');
      List<ProjectModel> temp = [];
      availableList.value=[];
      response.data.forEach((v) {
        Map<String, dynamic> map = v;
        ProjectModel projectModel = ProjectModel.fromJson(map);
        temp.add(projectModel);
      });
      availableList.value = temp;
      log('Project:${temp.length}');
      return true;
    } on DIO.DioException catch (e) {
      log("Error: ${e.toString()}");
      log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return false;
    }
  }

  Future<String?> addProject(Map<String, dynamic> map) async {
    Map<String, dynamic> addProjectMap = {
      "start_date": formatDateTime(startDate.value!),
      "end_date": formatDateTime(endDate.value!),
    };
    addProjectMap.addAll(map);
    log('AddValue: ${addProjectMap}');
    const projectUrl = PROJECT_ADD_URL;
    try {
      final DIO.Response response = await dio.post(projectUrl);
      log("Response: ${response.data.toString()}");
      return response.data['message']??'Added Successfully';
    } on DIO.DioException catch (e) {
      log("Error: ${e.toString()}");
      log("${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return null;
    }
  }
}
