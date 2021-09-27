import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DataBase {
  late final Database dataBase;

  DataBase();

  void createDataBase(
      {required String databaseName,
      required int databaseVersion,
      FutureOr<void> Function(Database)? onOpened,
      required String table}) async{
    openDatabase(databaseName, version: databaseVersion,
        onCreate: (database, version) {
      database.execute(table);
    }, onOpen: onOpened);
  }
}
