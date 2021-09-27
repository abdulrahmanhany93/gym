import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../constants/controller.dart';
import 'myFieldForm_widget.dart';


class TopBar extends StatelessWidget {
  final double height;
  final double width;
  final String searchHint;
  final String addToolTip;
  final Function(String value) searchAction;
  final Function() addAction;

  TopBar(
      {required this.height,
        required this.width,
        required this.addToolTip,
        required this.addAction,
        required this.searchHint,
        required this.searchAction});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConditionalBuilder(
              condition: cubit.currentIndex == 1 || cubit.currentIndex == 2,
              builder: (context) => IconButton(
                  onPressed: addAction,
                  tooltip: addToolTip,
                  icon: Icon(
                    FontAwesomeIcons.userPlus,
                    color: Colors.white,
                    size: 30,
                  )),
              fallback: (context) => IconButton(
                  onPressed: () {
                    cubit.getExpiredSubscriptions();
                  },
                  tooltip: 'Refresh',
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            Container(
              width: width * 0.2,
              height: height * 0.035,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)),
              child: MyFieldForm(
                controller: MyTextController.search,
                iconData: Icons.search,
                onSubmittedAction: searchAction,
                hint: searchHint,
              ),
            )
          ],
        ));
  }
}