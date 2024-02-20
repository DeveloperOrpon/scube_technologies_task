class ProjectModel {
  num? id;
  String? startDate;
  String? endDate;
  num? startDayOfYear;
  num? endDayOfYear;
  String? projectName;
  String? projectUpdate;
  String? assignedEngineer;
  String? assignedTechnician;
  num? duration;

  ProjectModel(
      {this.id,
        this.startDate,
        this.endDate,
        this.startDayOfYear,
        this.endDayOfYear,
        this.projectName,
        this.projectUpdate,
        this.assignedEngineer,
        this.assignedTechnician,
        this.duration});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startDayOfYear = json['start_day_of_year'];
    endDayOfYear = json['end_day_of_year'];
    projectName = json['project_name'];
    projectUpdate = json['project_update'];
    assignedEngineer = json['assigned_engineer'];
    assignedTechnician = json['assigned_technician'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_day_of_year'] = this.startDayOfYear;
    data['end_day_of_year'] = this.endDayOfYear;
    data['project_name'] = this.projectName;
    data['project_update'] = this.projectUpdate;
    data['assigned_engineer'] = this.assignedEngineer;
    data['assigned_technician'] = this.assignedTechnician;
    data['duration'] = this.duration;
    return data;
  }
}