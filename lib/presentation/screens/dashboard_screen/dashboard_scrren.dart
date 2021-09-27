import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../business_logic/cubit/cubit.dart';
import '../../widgets/employeesCard_widget.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class DashboardScreen extends StatelessWidget {
  final AppCubit cubit;

  const DashboardScreen(this.cubit);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainTopBar(width),
          _buildStatusCards(height, context, width),
          _buildEmployeesSection(height, width),
        ],
      ),
    );
  }

  Container _buildEmployeesSection(double height, double width) {
    return Container(
          height: height * 0.4,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.employees.length,
              itemBuilder: (context, index) {
                return EmployeesCard(
                    height: height,
                    width: width,
                    employee: cubit.employees[index]);
              }),
        );
  }

  Container _buildStatusCards(double height, BuildContext context, double width) {
    return Container(
          height: height * 0.4,
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              _buildStatisticsCard(
                title: 'Total Members',
                count: AppCubit.get(context).members.length,
                width: width,
              ),
              _buildStatisticsCard(
                title: 'Expired Subscriptions',
                count: AppCubit.get(context).expiredSubscriptions.length,
                width: width,
              ),
              _buildStatisticsCard(
                title: 'Total Employees',
                count: AppCubit.get(context).employees.length,
                width: width,
              ),
              Expanded(
                child: Image.asset(
                  'assets/public/3.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        );
  }

  ListTile _buildMainTopBar(double width) {
    return ListTile(
          title: Text(
            'Good Morning \n Abdul-Rahman',
            style: TextStyle(
                fontSize: width * 0.025,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.2),
          ),
          subtitle: Text('Control and analyze your data in the easiest way',
              style: TextStyle(
                  fontSize: width * 0.015,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  height: 2)),
          trailing: DigitalClock(
            areaDecoration: BoxDecoration(color: Colors.transparent),
            areaAligment: AlignmentDirectional.center,
            hourMinuteDigitDecoration:
                BoxDecoration(color: Colors.transparent),
            hourMinuteDigitTextStyle: TextStyle(
              fontSize: width * 0.025,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            is24HourTimeFormat: false,
            showSecondsDigit: false,
          ),
        );
  }
}

Container _buildStatisticsCard({
  required String title,
  required int count,
  required double width,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width * 0.015),
    margin: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: 100),
    width: width * 0.15,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber, Colors.amberAccent]),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          trailing: Icon(
            FontAwesomeIcons.users,
            size: width * 0.02,
            color: Colors.white,
          ),
          title: Text(
            title,
            style:
                TextStyle(fontSize: width * 0.01, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '$count',
          style: TextStyle(fontSize: width * 0.02, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
