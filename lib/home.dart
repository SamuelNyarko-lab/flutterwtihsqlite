// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterwithsql/sql/sqlite_service.dart';
import 'dart:async';
import 'sql/employee.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String firstname, surname;
  Future<List<Employee>>? employees = null;
  late int curUserId, age;
  final formKey = GlobalKey<FormState>();
  bool isUpdating = false;
  var dbHelper;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = SqliteService();
    isUpdating = false;
  }

  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  clearName() {
    textEditingController.text = '';
  }

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (isUpdating) {
        Employee employee = Employee(curUserId, age, firstname, surname);
        dbHelper.update(employee);
        clearName();
        isUpdating = false;
      }
    } else {
      Employee employee = Employee(curUserId, age, firstname, surname);
      dbHelper.save(employee);
    }
    refreshList();
  }

  list() {
    return Expanded(
      child: FutureBuilder(
          future: employees,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               return dataTable(snapshot.data);
             // return Text('Data');
            }
            if (!snapshot.hasData) {
              return Text('No Data');
            }
            return CircularProgressIndicator();
          }),
    );
  }

  SingleChildScrollView dataTable(List<Employee> employees) {
    return SingleChildScrollView(
      child: DataTable(
          columns: const [
            DataColumn(
              label: Text('Firstname'),
            ),
            DataColumn(
              label: Text('Surname'),
            ),
            DataColumn(
              label: Text('Age'),
            ),
            DataColumn(
              label: Text('Delete'),
            ),
          ],
          rows: employees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.firstname),
                  ),
                  DataCell(
                    Text(employee.surname),
                  ),
                  DataCell(
                    Text(employee.age.toString()),
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(employee.id);
                      refreshList();
                    },
                  ))
                ]),
              )
              .toList()),
    );
  }

  form() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Firstname'),
              validator: ((value) => value!.isEmpty ? 'Enter Firstname' : null),
              onSaved: ((newValue) => firstname = newValue!),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Surname'),
              validator: ((value) => value!.isEmpty ? 'Enter Surname' : null),
              onSaved: ((newValue) => surname = newValue!),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'Age'),
              validator: ((value) => value!.isEmpty ? 'Enter Age' : null),
              onSaved: ((newValue) => age = newValue! as int),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: validate,
                child: AutoSizeText(isUpdating ? 'Update' : 'Save'),
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isUpdating = false;
                  });
                  clearName();
                },
                child: AutoSizeText('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText('Flutter With Sqlite'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            form(),
            SizedBox(
              height: 20,
            ),
            list(),
          ],
        ),
      ),
    );
  }
}
