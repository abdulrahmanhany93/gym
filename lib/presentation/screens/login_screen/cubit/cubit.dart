import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/const.dart';
import 'states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController logUserNameController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();

  static LogInCubit get(context) => BlocProvider.of(context);

  void logIn(String username, String password) {
    emit(LogInLoadingState());
    if (users.containsKey(username) && users.containsValue(password)) {
      emit(LogInFinishState());
    } else {
      formKey.currentState!.validate();
      emit(LogInErrorState());
    }
  }
}
