import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../business_logic/cubit/cubit.dart';

class Menu extends StatelessWidget {
  final Map menuContent;
  final AppCubit cubit;

  const Menu({
    required this.menuContent,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: menuContent.keys.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ListTile(
                  leading: IconButton(
                    tooltip: menuContent.keys.elementAt(index),
                    color: Colors.white,
                    iconSize: MediaQuery.of(context).size.height * 0.025,
                    icon: Icon(menuContent.values.elementAt(index)),
                    onPressed: () {
                      cubit.changePageViewIndex(index);
                    },
                  ),
                  trailing: ConditionalBuilder(
                    condition: cubit.currentIndex == index,
                    builder: (context) => Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    fallback: (context) => SizedBox(),
                  )),
            );
          }),
    );
  }
}