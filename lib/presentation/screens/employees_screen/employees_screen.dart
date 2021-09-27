import 'package:flutter/material.dart';
import 'package:gym/constants/components/components.dart';
import 'package:gym/presentation/widgets/sheet_widget.dart';
import '../../../business_logic/cubit/cubit.dart';
import '../../../constants/const.dart';
import '../../../constants/controller.dart';
import '../../widgets/employeesCard_widget.dart';
import '../../widgets/topBar_widget.dart';


class EmployeesScreen extends StatelessWidget {
  final AppCubit cubit;

  const EmployeesScreen(this.cubit, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        TopBar(
            height: h,
            width: w,
            addToolTip: 'Add Employee',
            addAction: () {
              _buildShowModalBottomSheet(context, w, h);
            },
            searchHint: 'Search By Name',
            searchAction: (value) {
              cubit.searchListUpdate(value, cubit.employees);
            }),
        _buildEmployeesGridView(w, h),
        SizedBox(
          height: 10,
        )
      ],
    ));
  }

  Expanded _buildEmployeesGridView(double w, double h) {
    return Expanded(
      child: GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1.11),
          itemCount: MyTextController.search.text.isEmpty
              ? cubit.employees.length
              : cubit.searchList.length,
          itemBuilder: (context, index) {
            return EmployeesCard(
                width: w,
                height: h,
                employee: MyTextController.search.text.isEmpty
                    ? cubit.employees[index]
                    : cubit.searchList[index]);
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
              controllers: employeeControllers,
              saveAction: saveAction(context, cubit, 'Employee'),
              removeAction: () {
                removeAction(context, cubit, 'Employee',
                    name: MyTextController.name.text);
              });
        });
  }
}
