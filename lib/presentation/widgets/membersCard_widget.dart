import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/constants/components/components.dart';
import 'package:gym/presentation/widgets/sheet_widget.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../constants/const.dart';
import '../../constants/controller.dart';
import '../../data/model/member.dart';

class MembersCard extends StatelessWidget {
  const MembersCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.member})
      : super(key: key);

  final Member member;

  final double width;
  final double height;

  @override
  Widget build(BuildContext contexts) {
    var cubit = AppCubit.get(contexts);
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black54,
                Colors.amber.shade800,
                Colors.amberAccent.shade700,
              ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(
                        fontSize: width * 0.014,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: isSubscriptionEnded(cubit, member)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.red,
                        decorationThickness: 2),
                  ),
                  Image.asset(
                    member.gender == 'Female'
                        ? 'assets/members/1.png'
                        : 'assets/members/2.png',
                  )
                ],
              ),
              Text(
                'ID : ${member.id}',
                style: TextStyle(
                    fontSize: width * 0.009,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Age : ${member.age}',
                style: TextStyle(
                    fontSize: width * 0.009,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Subscription : ${member.subscriptionsType} ',
                style: TextStyle(
                    fontSize: width * 0.009,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Date : ${member.startDate.substring(0, 10)}',
                    style: TextStyle(
                        fontSize: width * 0.009,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  ConditionalBuilder(
                      condition: cubit.currentIndex == 2,
                      builder: (contexts) => IconButton(
                          onPressed: () {
                            MyTextController.name.text = member.name;
                            MyTextController.gender.text = member.gender;
                            MyTextController.age.text = '${member.age}';
                            MyTextController.subscriptions.text =
                                member.subscriptionsType;
                            MyTextController.startDate.text = member.startDate;
                            showModalBottomSheet(
                                context: contexts,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Sheet(
                                      w: width,
                                      h: height,
                                      cubit: cubit,
                                      controllers: memberController,
                                      saveAction: () {
                                        cubit.updateMembersDataBase(
                                            name: MyTextController.name.text,
                                            id: member.id,
                                            gender:
                                                MyTextController.gender.text,
                                            age: int.parse(
                                                MyTextController.age.text),
                                            subscriptionsType: MyTextController
                                                .subscriptions.text,
                                            startDate:
                                                MyTextController.startDate.text,
                                            endDate: cubit.getEndDate(
                                                MyTextController.startDate.text,
                                                MyTextController
                                                    .subscriptions.text));
                                        Navigator.pop(context);
                                        clearFields();
                                      },
                                      removeAction: () {
                                        removeAction(context, cubit, 'Member',
                                            id: member.id);
                                      },
                                    ));
                          },
                          icon: Icon(Icons.edit)),
                      fallback: (context) => IconButton(
                          onPressed: () {
                            renewAction(contexts, cubit, member.id,
                                member.subscriptionsType);
                          },
                          icon: Icon(Icons.update)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
