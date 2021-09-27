import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'controller.dart';

final GlobalKey<FormState> formKey1 = GlobalKey();
final PageController pageViewController = PageController();
final ScrollController scrollController = ScrollController();
Map<String, String> users = {'admin': '1234', 'bedo': '123'};

final Map<String, List> employeeControllers = {
  'Name': [MyTextController.name, Icons.person],
  'Age': [MyTextController.age, Icons.person],
  'Job': [MyTextController.job, Icons.work],
  'Salary': [MyTextController.salary, Icons.attach_money],
  'Gender': [MyTextController.gender, Icons.person],
};
final Map<String, List> memberController = {
  'Name': [MyTextController.name, Icons.person],
  'Age': [MyTextController.age, Icons.person],
  'Gender': [MyTextController.gender, Icons.person],
  'Subscriptions': [MyTextController.subscriptions, Icons.info_outline],
  'StartDate': [MyTextController.startDate, Icons.date_range],
};
final Map<String, IconData> menu = {
  'Dashboard': FontAwesomeIcons.chartArea,
  'Employees': FontAwesomeIcons.user,
  'Members': FontAwesomeIcons.users,
  'Expired Subscriptions': FontAwesomeIcons.stopwatch,
  'Equipments': FontAwesomeIcons.dumbbell,
  'supplements': FontAwesomeIcons.capsules,
  'About': FontAwesomeIcons.info,
};

final Map<String, int> cardContent = {
  'Total Members': 2000,
  'Expired Subscriptions': 30,
  'Total Employees': 50
};
