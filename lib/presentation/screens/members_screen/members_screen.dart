import 'package:flutter/material.dart';
import 'package:gym/constants/components/components.dart';
import 'package:gym/presentation/widgets/sheet_widget.dart';
import '../../../business_logic/cubit/cubit.dart';
import '../../../constants/const.dart';
import '../../../constants/controller.dart';
import '../../widgets/membersCard_widget.dart';
import '../../widgets/topBar_widget.dart';

class MembersScreen extends StatelessWidget {
  final AppCubit cubit;

  MembersScreen(this.cubit);

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    List searchList = AppCubit.get(context).searchList;
    List publicList = AppCubit.get(context).members;
    return Scaffold(
        body: Column(
      children: [
        TopBar(
            height: h,
            width: w,
            addToolTip: 'Add Member',
            addAction: () {
              clearFields();
              _buildShowModalBottomSheet(context, w, h);
            },
            searchHint: 'Search By ID',
            searchAction: (value) {
              cubit.searchListUpdate(value, cubit.members);
            }),
        _buildMembersGridView(h, publicList, searchList, w),
        SizedBox(
          height: 10,
        )
      ],
    ));
  }

  Expanded _buildMembersGridView(
      double h, List<dynamic> publicList, List<dynamic> searchList, double w) {
    return Expanded(
      child: GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: h * 0.04,
              childAspectRatio: 2),
          itemCount: MyTextController.search.text.isEmpty
              ? publicList.length
              : searchList.length,
          itemBuilder: (context, index) {
            return MembersCard(
              member: MyTextController.search.text.isEmpty
                  ? publicList[index]
                  : searchList[index],
              width: w,
              height: h,
            );
          }),
    );
  }

  Future<dynamic> _buildShowModalBottomSheet(
      BuildContext context, double w, double h) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Sheet(
              w: w,
              h: h,
              cubit: cubit,
              controllers: memberController,
              saveAction: () {
                saveAction(context, cubit, 'Member');
              },
              removeAction: () {
                removeAction(context, cubit, 'Member', name: 'no action');
              });
        });
  }
}
