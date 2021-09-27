class Employee {
  final String name;
  final int age;
  final String profileImage;
  final String job;
  final double salary;

  Employee(
      {required this.name,
      required this.age,
      this.profileImage = 'assets/trainers/boy.png',
      required this.job,
      required this.salary});
}
