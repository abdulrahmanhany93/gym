import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/business_logic/cubit/cubit.dart';
import 'package:gym/data/model/member.dart';
import '../controller.dart';

// ignore: must_be_immutable

button({
  required double w,
  required double h,
  required String title,
  required Function() action,
}) {
  return GestureDetector(
    onTap: action,
    child: Container(
      width: w * 0.06,
      height: h * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Center(child: Text(title)),
    ),
  );
}

datePicker(context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2001),
    lastDate: DateTime(2055),
  ).then((value) => MyTextController.startDate.text = value.toString());
}

showSnackBar(context, String title, double fontSize) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      title,
      style: TextStyle(fontSize: fontSize),
    ),
    backgroundColor: Colors.amber,
  ));
}

Future navigateTo(context, Widget widget) {
  return Navigator.push(context, MaterialPageRoute(builder: (__) => widget));
}

navigateToAndFinish(context, Widget widget) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (__) => widget));
}

saveAction(BuildContext context, AppCubit cubit, String type) {
  if (type == 'Member' && MyTextController.name.text.isNotEmpty) {
    cubit.insertMember(
      name: MyTextController.name.text,
      gender: MyTextController.gender.text,
      age: int.parse(MyTextController.age.text),
      subscriptionsType: MyTextController.subscriptions.text,
      startDate: MyTextController.startDate.text,
      endDate: cubit.getEndDate(
          MyTextController.startDate.text, MyTextController.subscriptions.text),
    );
    clearFields();
    Navigator.of(context).pop();
  }
  if (type == 'Employee') {
    cubit.insertEmployee(
        name: MyTextController.name.text,
        gender: MyTextController.gender.text,
        age: int.parse(MyTextController.age.text),
        job: MyTextController.job.text,
        salary: double.parse(MyTextController.salary.text));
    clearFields();
    Navigator.of(context).pop();
  }
}

removeAction(BuildContext context, AppCubit cubit, String type,
    {int id = 0, String name = ''}) {
  if (type == 'Member') {
    cubit.removeMember(id: id);
    clearFields();
    Navigator.of(context).pop();
  }
  if (type == 'Employee') {
    cubit.removeEmployee(name: name);
    clearFields();
    Navigator.of(context).pop();
  }
}

renewAction(
    BuildContext context, AppCubit cubit, int id, String subscriptionType) {
  cubit.renewMemberSubscriptions(id: id, subscriptionType: subscriptionType);
  cubit.getExpiredSubscriptions();
}

bool isSubscriptionEnded(AppCubit cubit, Member member) {
  return cubit.expiredSubscriptions
          .any((element) => element.name.contains(member.name)) &&
      cubit.currentIndex == 2;
}
