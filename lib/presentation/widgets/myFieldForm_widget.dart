import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/components/components.dart';
import '../../constants/controller.dart';

class MyFieldForm extends StatelessWidget {
  const MyFieldForm({
    Key? key,
    this.showCursor = true,
    required this.onSubmittedAction,
    required this.hint,
    required this.iconData,
    required this.controller,
  }) : super(key: key);

  final Function(String value) onSubmittedAction;

  final TextEditingController controller;
  final IconData iconData;
  final String hint;
  final bool showCursor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onSubmittedAction,
      onTap: () {
        if (controller == MyTextController.startDate) {
          datePicker(context);
        } else if (controller == MyTextController.gender) {
          MyTextController.gender.text == 'male'
              ? MyTextController.gender.text = 'Female'
              : MyTextController.gender.text = 'Male';
        } else if (controller == MyTextController.subscriptions) {
          MyTextController.subscriptions.text == 'Month'
              ? MyTextController.subscriptions.text = 'Year'
              : MyTextController.subscriptions.text = 'Month';
        }
      },
      textAlign: TextAlign.justify,
      showCursor: showCursor,
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if ((controller == MyTextController.salary) &&
            (controller.text.isNotEmpty)) {
          while (num.tryParse(controller.text) is! num) {
            return 'Please Enter Numbers';
          }
        } else if ((controller == MyTextController.age) &&
            (controller.text.isNotEmpty)) {
          while (int.tryParse(controller.text) is! int) {
            return 'Please Enter Integer';
          }
        }
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.amber,
          hintText: hint,
          icon: Icon(
            iconData,
            color: Colors.black54,
          )),
    );
  }
}