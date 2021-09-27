import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EmployeesCard extends StatelessWidget {
  const EmployeesCard({
    Key? key,
    required this.width,
    required this.height,
    required this.employee,
  }) : super(key: key);

  final double width;
  final double height;
  final Map<String, dynamic> employee;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.014, vertical: height * 0.09),
          width: width * 0.22,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.black54]),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
            width: width * 0.34,
            child: Image.asset(
              employee['profileImage'],
              height: height * 0.31,
            )),
        Positioned(
          top: height * 0.15,
          left: width * 0.02,
          child: Text(
            '${employee['name']}',
            style: TextStyle(
                fontSize: width * 0.013,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: height * 0.2,
          left: width * 0.03,
          child: Text(
            '${employee['job']}',
            style: TextStyle(
                fontSize: width * 0.01,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}