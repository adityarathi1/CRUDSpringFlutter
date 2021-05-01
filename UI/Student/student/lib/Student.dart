import 'package:flutter/material.dart';

class Student {
  String id;
  String name;
  String age;
  String std;

  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController stdController;

  Student({this.age, this.id, this.name, this.std}) {}

  Student update() {
    this.ageController.text = this.age;
    this.stdController.text = this.std;
    this.nameController.text = this.name;
    return this;
  }
}
