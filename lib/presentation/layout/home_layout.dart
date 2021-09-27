import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../constants/components/components.dart';
import '../../constants/const.dart';
import '../screens/about_screen/about_screen.dart';
import '../screens/dashboard_screen/dashboard_scrren.dart';
import '../screens/employees_screen/employees_screen.dart';
import '../screens/equipments_screen/equipments_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/members_screen/members_screen.dart';
import '../screens/subscriptions_screen/subscriptions_screen.dart';
import '../screens/supplements_screen/supplements_screen.dart';
import '../widgets/menu_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! AppLoadingDataBase,
              builder: (context) => _buildHomeScreenBody(height, context),
              fallback: (context) => Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              )),
            ),
          );
        },
      ),
    );
  }

  Stack _buildHomeScreenBody(double height, BuildContext context) {
    return Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/public/2.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                _buildSideMenu(height, context),
                Container(
                  child: MoveWindow(),
                  height: height * 0.05,
                ),
              ],
            );
  }

  Row _buildSideMenu(double height, BuildContext context) {
    return Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height * 0.1),
                    width: MediaQuery.of(context).size.width * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Menu(
                          menuContent: menu,
                          cubit: AppCubit.get(context),
                        ),
                        IconButton(
                          onPressed: () =>
                              navigateToAndFinish(context, LogInScreen()),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          icon: Icon(Icons.exit_to_app),
                          color: Colors.white,
                          iconSize: 40,
                          tooltip: 'LogOut',
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: PageView(
                    controller: pageViewController,
                    children: screens(AppCubit.get(context)),
                    physics: NeverScrollableScrollPhysics(),
                  )),
                ],
              );
  }
}

List<Widget> screens(AppCubit cubit) {
  return [
    DashboardScreen(
      cubit,
    ),
    EmployeesScreen(cubit),
    MembersScreen(cubit),
    SubscriptionsScreen(cubit),
    EquipmentsScreen(cubit),
    SupplementsScreen(cubit),
    AboutScreen()
  ];
}
