import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/business_logic/cubit/cubit.dart';
import 'package:gym/constants/components/components.dart';
import 'package:gym/constants/controller.dart';
import 'package:gym/presentation/widgets/myFieldForm_widget.dart';

class Sheet extends StatelessWidget {
  const Sheet({
    required this.w,
    required this.h,
    required this.cubit,
    required this.controllers,
    required this.saveAction,
    required this.removeAction,
  });

  final String defaultImage = 'assets/trainers/boy.png';
  final double w;
  final double h;
  final AppCubit cubit;
  final Map<String, List> controllers;
  final Function() saveAction;
  final Function() removeAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.65,
      margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.1),
      height: h * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [Colors.amber, Colors.amberAccent.withOpacity(0.6)])),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              itemCount: controllers.keys.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: w * 0.005),
                  margin: EdgeInsets.symmetric(
                      vertical: h * 0.02, horizontal: w * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15)),
                  child: MyFieldForm(
                    onSubmittedAction: (value) {},
                    hint: mapName(controllers, index),
                    iconData: mapControllerIcon(controllers, index),
                    controller: mapController(controllers, index),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Image.asset(
              defaultImage,
            ),
          ),
          Expanded(
              flex: 2,
              child: ListTile(
                leading: MyTextController.name.text.isNotEmpty
                    ? button(title: 'Remove', action: removeAction, w: w, h: h)
                    : SizedBox(),
                title: button(
                  title: 'Save',
                  action: saveAction,
                  h: h,
                  w: w,
                ),
              ))
        ],
      ),
    );
  }
}
