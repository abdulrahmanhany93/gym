import 'package:flutter/cupertino.dart';
import 'const.dart';

class MyTextController {
  static final TextEditingController name = TextEditingController();
  static final TextEditingController age = TextEditingController();
  static final TextEditingController salary = TextEditingController();
  static final TextEditingController gender =
      TextEditingController(text: 'Male');
  static final TextEditingController job = TextEditingController();
  static final TextEditingController subscriptions =
      TextEditingController(text: 'Month');
  static final TextEditingController startDate =
      TextEditingController(text: DateTime.now().toString());
  static final TextEditingController search = TextEditingController();
}

mapName(Map<String, List> map, int index) {
  return map.keys.elementAt(index);
}

mapController(Map<String, List> map, int index) {
  return map.entries.elementAt(index).value.elementAt(0);
}

mapControllerIcon(Map<String, List> map, int index) {
  return map.entries.elementAt(index).value.elementAt(1);
}

bool checkControllerValue(map, index, controller) {
  if (controller == mapController(map, index)) {
    return true;
  }
  return false;
}

clearFields() {
  employeeControllers.entries.forEach((element) {
    element.value[0].clear();
  });
  memberController.entries.forEach((element) {
    element.value[0].clear();
  });
}
