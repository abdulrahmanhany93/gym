import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/const.dart';
import '../../constants/controller.dart';
import '../../data/model/member.dart';


import 'states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  late final Database membersDataBase;
  late final Database employeesDataBase;
  List<Member> members = [];
  List<Map<String, dynamic>> employees = [];
  List<Member> expiredSubscriptions = [];
  List searchList = [];
  int currentIndex = 0;

  static AppCubit get(context) => BlocProvider.of(context);

  void createDataBase() async {
    emit(AppLoadingDataBase());
    openDatabase('members.db', version: 2, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE Members (id INTEGER PRIMARY KEY, name TEXT, gender TEXT, age INTEGER, subscriptionsType TEXT,startDate TEXT,endDate TEXT)');
    }).then((value) {
      membersDataBase = value;
      getData(membersDataBase, 'Members')
          .then((value) => value.forEach((element) {
                members.add(Member.fromDataBase(element));
              }))
          .then((value) {
        expiredSubscriptions = members
            .where((element) =>
                DateTime.now().isAfter(DateTime.parse(element.endDate)))
            .toList();
        print(members.last.toString());
      });
    });

    openDatabase(
      'employees.db',
      version: 2,
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, gender TEXT, age INTEGER, job TEXT,profileImage TEXT,salary REAL)');
      },
    ).then((value) {
      employeesDataBase = value;
      getData(employeesDataBase, 'Employees')
          .then((value) => employees = value)
          .then((value) => emit(AppDataBaseLoaded()));
    });
  }

  Future<List<Map<String, dynamic>>> getData(database, String tableName) {
    return database.query(tableName);
  }

  void insertMember(
      {required String name,
      required String gender,
      required int age,
      required String subscriptionsType,
      required String startDate,
      required String endDate}) {
    membersDataBase.insert('Members', {
      'name': name,
      'gender': gender,
      'age': age,
      'subscriptionsType': subscriptionsType,
      'startDate': startDate,
      'endDate': endDate
    }).then((value) {
      members.add(Member(
          name: name,
          id: members.length + 1,
          gender: gender,
          age: age,
          subscriptionsType: subscriptionsType,
          startDate: startDate,
          endDate: endDate));

      emit(AppDateBaseInserted());
      print(members.last.name);
    });
  }

  void insertEmployee({
    required String name,
    required String gender,
    required int age,
    required String job,
    required double salary,
  }) {
    employeesDataBase.insert('Employees', {
      'name': name,
      'gender': gender,
      'age': age,
      'job': job,
      'salary': salary,
      'profileImage': gender == 'Male'
          ? 'assets/trainers/boy.png'
          : 'assets/trainers/girl.png'
    }).then((value) {
      getData(employeesDataBase, 'Employees')
          .then((value) => employees = value);
      emit(AppDateBaseInserted());
    });
  }

  void updateMembersDataBase(
      {required String name,
      required int id,
      required String gender,
      required int age,
      required String subscriptionsType,
      required String startDate,
      required String endDate}) {
    membersDataBase
        .update(
            'Members',
            {
              'name': name,
              'gender': gender,
              'age': age,
              'subscriptionsType': subscriptionsType,
              'startDate': startDate,
              'endDate': endDate
            },
            where: 'id = $id')
        .then((value) => getData(membersDataBase, 'Members'))
        .then((value) => members.forEach((element) {
              if (element.id == id) {
                element.name = name;
                element.startDate = startDate;
                element.endDate = endDate;
                element.gender = gender;
                element.age = age;
                element.subscriptionsType = subscriptionsType;
              }
            }))
        .then((value) {
      expiredSubscriptions = members
          .where((element) =>
              DateTime.now().isAfter(DateTime.parse(element.endDate)))
          .toList();
      emit(AppDataBaseUpdated());
    });
  }

  void removeMember({
    required int id,
  }) {
    membersDataBase
        .delete('Members', where: 'id = $id')
        .then((value) => members.removeWhere((element) => element.id == id))
        .then((value) => emit(AppDataBaseMemberRemoved()));
  }

  void removeEmployee({
    required String name,
  }) {
    employeesDataBase
        .delete('Employees', where: 'name = $name')
        .then((value) => getData(employeesDataBase, 'Employee'))
        .then((value) => employees = value)
        .then((value) => emit(AppDataBaseEmployeeRemoved()));
  }

  getExpiredSubscriptions() {
    expiredSubscriptions = members
        .where((element) =>
            DateTime.now().isAfter(DateTime.parse(element.endDate)))
        .toList();
    emit(AppDataBaseUpdated());
  }

  void renewMemberSubscriptions(
      {required int id, required String subscriptionType}) {
    membersDataBase
        .update(
            'Members',
            {
              'startDate': DateTime.now().toString(),
              'endDate': getEndDate(DateTime.now().toString(), subscriptionType)
            },
            where: 'id = $id')
        .then((value) => members.forEach((element) {
              if (element.id == id) {
                element.startDate = DateTime.now().toString();
                element.endDate =
                    getEndDate(DateTime.now().toString(), subscriptionType);
              }
            }))
        .then((value) {
      expiredSubscriptions = members
          .where((element) =>
              DateTime.now().isAfter(DateTime.parse(element.endDate)))
          .toList();
      emit(AppDataBaseMemberRenew());
    });
  }

  void changePageViewIndex(int index) {
    currentIndex = index;
    pageViewController.animateToPage(currentIndex,
        duration: Duration(milliseconds: 650), curve: Curves.fastOutSlowIn);
    MyTextController.search.clear();
    emit(AppPageViewChange());
  }

  void searchListUpdate(String value, List list) {
    if (value.isEmpty || value == '') {
      searchList.clear();
    }
    if (list == employees) {
      searchList = list
          .where((element) => element.name.toLowerCase().startsWith(value))
          .toList();
      emit(AppSearchListUpdate());
    }
    if (list == members) {
      searchList =
          list.where((element) => element.name.contains(value)).toList();
      emit(AppSearchListUpdate());
    }
  }

  String getEndDate(String value, String subscriptionType) {
    if (subscriptionType == 'Month') {
      DateTime x = DateTime.parse(value);
      DateTime endDate = x.add(Duration(seconds: 1));
      print(endDate.toString());
      return endDate.toString();
    } else {
      DateTime x = DateTime.parse(value);
      DateTime endDate = x.add(Duration(seconds: 1));
      print(endDate.toString());
      return endDate.toString();
    }
  }
}
