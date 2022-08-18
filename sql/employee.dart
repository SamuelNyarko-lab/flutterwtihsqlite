import 'package:sqflite/sqflite.dart';

class Employee {
  String firstname, surname;
  late int age, id;
  Employee(this.id, this.age, this.firstname, this.surname);

//Converts values into map to insert into database
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'age': age,
      'firstname': firstname,
      'surname': surname
    };
    return map;
  }


//Converts map data into values
  Employee.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        age = map['age'],
        firstname = map['firstname'],
        surname = map['surname'];


}
