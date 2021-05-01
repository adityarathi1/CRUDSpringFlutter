import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:student/HttpClient.dart';
import 'package:student/StudentModal.dart';

import 'Student.dart';

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Text> _headerList = [];
  List<Student> _studentList = [];
  Border _headerBorder = Border.all(color: Color(0XFFD96A5F));
  Border _bodyBorder = Border.all(color: Colors.white);
  @override
  void initState() {
    _headerList = [
      getTableHeaderText("ID"),
      getTableHeaderText("Student Name"),
      getTableHeaderText("Age"),
      getTableHeaderText("Class"),
      getTableHeaderText("Edit"),
      getTableHeaderText("Delete"),
    ];
    getStudentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "All Student List",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => StudentModal(
                            updateFlag: false,
                            callBack: modalCallback,
                          ));
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: LazyDataTable(
            rows: _studentList.length,
            columns: 6,
            tableDimensions: LazyDataTableDimensions(
              customCellWidth: {0: 100, 1: 200, 2: 100, 3: 100, 4: 100, 5: 100},
              cellHeight: 50,
              topHeaderHeight: 50,
              leftHeaderWidth: 75,
            ),
            tableTheme: LazyDataTableTheme(
              columnHeaderColor: Color(0XFFD96A5F),
              columnHeaderBorder: _headerBorder,
              cellBorder: _bodyBorder,
              alternateCellBorder: _bodyBorder,
            ),
            topHeaderBuilder: (i) => Center(child: _headerList[i]),
            dataCellBuilder: (i, j) => Center(child: getCellItem(i, j)),
          ),
        ),
      ],
    );
  }

  void modalCallback() {
    getStudentList();
  }

  Widget getCellItem(int i, int j) {
    switch (j) {
      case 0:
        return getTableBodyText(_studentList[i].id);
        break;
      case 1:
        return getTableBodyText(_studentList[i].name);
        break;
      case 2:
        return getTableBodyText(_studentList[i].age);
        break;
      case 3:
        return getTableBodyText(_studentList[i].std);
        break;
      case 4:
        return IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => StudentModal(
                        updateFlag: true,
                        student: _studentList[i],
                        callBack: modalCallback,
                      ));
            },
            icon: Icon(
              Icons.edit,
              color: Colors.brown,
            ));
        break;
      case 5:
        return IconButton(
            onPressed: () {
              _deleteData(i);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ));
        break;
      default:
        return Container();
        break;
    }
  }

  _deleteData(index) async {
    dynamic req = {"id": _studentList[index].id};

    callServer(req: json.encode(req), service: "delete").then((String res) {
      final snackBar = SnackBar(content: Text(res));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getStudentList();
    });
  }

  void getStudentList() async {
    String res = await callServer(
      req: "{}",
      service: "getAll",
    );
    if (res != null && res != "") {
      var data = json.decode(res);
      var studentList = data["data"];
      List<Student> studentObjList = [];
      for (int i = 0; i < studentList.length; i++) {
        studentObjList.add(
          Student(
            age: studentList[i]["age"].toString(),
            id: studentList[i]["id"].toString(),
            name: studentList[i]["studentName"],
            std: studentList[i]["class_std"].toString(),
          ),
        );
      }
      setState(() {
        _studentList = studentObjList;
      });
    }
  }

  Text getTableHeaderText(String data) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text getTableBodyText(String data) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
