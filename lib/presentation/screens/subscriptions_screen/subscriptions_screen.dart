import 'package:flutter/material.dart';
import '../../../business_logic/cubit/cubit.dart';
import '../../../constants/const.dart';
import '../../../constants/controller.dart';
import '../../widgets/membersCard_widget.dart';
import '../../widgets/topBar_widget.dart';


class SubscriptionsScreen extends StatelessWidget {
  final AppCubit cubit;

  const SubscriptionsScreen(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    List searchList = AppCubit.get(context).searchList;
    return Scaffold(
        body: Column(
      children: [
        TopBar(
            height: h,
            width: w,
            addToolTip: 'Add Employee',
            addAction: () {},
            searchHint: 'Search By ID',
            searchAction: (value) {
              cubit.searchListUpdate(value, cubit.expiredSubscriptions);
            }),
        _buildMembersGridView(h, cubit.expiredSubscriptions, searchList, w),
        SizedBox(
          height: 10,
        )
      ],
    ));
  }
}

Widget _buildMembersGridView(
    double h, List<dynamic> publicList, List<dynamic> searchList, double w) {
  return Expanded(
    child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: h * 0.04, childAspectRatio: 2),
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
