import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/cubit.dart';
import '../../../constants/components/components.dart';
import '../../layout/home_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: Scaffold(
        body: BlocConsumer<LogInCubit, LogInStates>(
          listener: (context, LogInStates state) {
            _checkState(state, context);
          },
          builder: (context, state) {
            var login = LogInCubit.get(context);
            return Form(
              key: login.formKey,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/public/2.jpg'),
                        fit: BoxFit.cover)),
                child: _buildLogInForm(login, width, height, context),
              ),
            );
          },
        ),
      ),
    );
  }

  void _checkState(LogInStates state, BuildContext context) {
    if (state is LogInFinishState) {
      navigateTo(context, HomeScreen())
          .then((value) => AppCubit.get(context).createDataBase());
    }
    if (state is LogInErrorState) {
      showSnackBar(context, 'Please Check the Name & Password', 19);
    }
  }

  Column _buildLogInForm(
      LogInCubit login, double width, double height, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/public/3.png',
          height: 260,
        ),
        _buildLogInField(
            text: 'User Name',
            controller: login.logUserNameController,
            submittedAction: (value) {},
            secure: false,
            width: width,
            height: height),
        _buildLogInField(
            text: 'Password',
            controller: login.logPasswordController,
            submittedAction: (value) {
              LogInCubit.get(context).logIn(login.logUserNameController.text,
                  login.logPasswordController.text);
            },
            secure: true,
            width: width,
            height: height),
        GestureDetector(
          onTap: () {
            LogInCubit.get(context).logIn(login.logUserNameController.text,
                login.logPasswordController.text);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.45, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              'LogIn',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )),
          ),
        ),
      ],
    );
  }
}

Widget _buildLogInField(
    {required double width,
    required double height,
    required String text,
    required TextEditingController controller,
    required Function(String) submittedAction,
    required bool secure}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    margin:
        EdgeInsets.symmetric(horizontal: width * 0.4, vertical: height * 0.02),
    decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20)),
    child: TextFormField(
      controller: controller,
      onFieldSubmitted: submittedAction,
      obscureText: secure,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          hintStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          errorStyle: TextStyle(color: Colors.redAccent.shade700)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Type Your $text';
        } else {
          return 'Please Check Your $text';
        }
      },
    ),
  );
}
