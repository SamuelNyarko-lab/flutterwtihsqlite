class Employee {
  String firstname, surname;
  int age, id;
  Employee(this.id, this.age, this.firstname, this.surname);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'age': age,
      'firstname': firstname,
      'surname': surname
    };
    return map;
  }

  // Employee.fromMap(Map<String, dynamic> map){
  //   id = map['id']
  // }
}
