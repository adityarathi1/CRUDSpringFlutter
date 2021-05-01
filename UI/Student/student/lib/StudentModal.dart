import 'dart:convert';

import 'package:flutter/material.dart';

import '../../components.dart';
import 'HttpClient.dart';
import 'Student.dart';

class StudentModal extends StatefulWidget {
  final Student student;
  final bool updateFlag;
  final Function callBack;

  StudentModal({this.student, this.updateFlag, this.callBack});
  @override
  _StudentModalState createState() => _StudentModalState();
}

class _StudentModalState extends State<StudentModal>
    with SingleTickerProviderStateMixin {
  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController stdController;

  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    stdController = TextEditingController();
    ageController = TextEditingController();

    if (widget.updateFlag) {
      nameController.text = widget.student.name;
      ageController.text = widget.student.age;
      stdController.text = widget.student.std;
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.3;
    double height = MediaQuery.of(context).size.height * 0.6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.02,
          ),
          width: width,
          height: height,
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              alignment: Alignment.topRight,
              scale: _scaleAnimation,
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: _getAddStudentView(width * 0.9, height),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getAddStudentView(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.updateFlag ? "Update Student" : "Add Student",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.04),
          getInputForm(width, height),
        ],
      ),
    );
  }

  _saveData() async {
    dynamic req = _getSaveRequest();
    String service = "add";
    if (widget.updateFlag) {
      service = "update";
    }

    callServer(req: json.encode(req), service: service).then((String res) {
      widget.callBack();
      final snackBar = SnackBar(content: Text(res));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  dynamic _getSaveRequest() {
    dynamic req = {};
    req["id"] =
        widget.updateFlag ? int.tryParse(widget.student.id) : int.tryParse("");
    req["studentName"] = nameController.text;
    req["age"] = int.tryParse(ageController.text);
    req["class_std"] = int.tryParse(stdController.text);
    return req;
  }

  Widget getInputForm(double width, double height) {
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.8,
            child: getRoundedTextField(
              labelText: "Student Name",
              controller: nameController,
            ),
          ),
          SizedBox(height: height * 0.04),
          Container(
            width: width * 0.8,
            child: getRoundedTextField(
                labelText: "Age", controller: ageController),
          ),
          SizedBox(height: height * 0.04),
          Container(
            width: width * 0.8,
            child: getRoundedTextField(
              labelText: "Class",
              controller: stdController,
            ),
          ),
          SizedBox(height: height * 0.04),
          ClipOval(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                splashColor: Colors.greenAccent,
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    )),
                onTap: _saveData,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
