// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText('Flutter With Sqlite'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: 'Firstname'),
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
                      onPressed: () {},
                      child: AutoSizeText('Save'),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: AutoSizeText('Cancel'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
