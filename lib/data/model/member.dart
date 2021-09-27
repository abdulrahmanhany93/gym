enum Gender { Male, Female }

class Member {
  late String name;
  late int age;
  late int id;
  late String gender;
  late String subscriptionsType;
  late String startDate;
  late String endDate;

  Member({
    required this.name,
    required this.id,
    required this.gender,
    required this.age,
    required this.subscriptionsType,
    required this.startDate,
    required this.endDate,
  });

  Member.fromDataBase(Map<String, dynamic> element) {
    name = element['name'];
    id = element['id'];
    gender = element['gender'];
    age = element['age'];
    subscriptionsType = element['subscriptionsType'];
    startDate = element['startDate'];
    endDate = element['endDate'];
  }
}
