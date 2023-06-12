import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/modal/todoModal.dart';
import 'package:to_do_app/view/homeScreen.dart';

import '../contoller/todoController.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  TodoController todoController = Get.put(TodoController());

  Map m1 = Get.arguments;
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtnotes = TextEditingController();

  @override
  void initState() {
    super.initState();

    todoController.d1.value = todoController.changeDate(DateTime.now());
    todoController.t1.value = todoController.changeTime(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    txttitle = TextEditingController(
        text: m1['status'] == 'update'
            ? todoController.dataList[m1['index']].title
            : "");
    txtnotes = TextEditingController(
        text: m1['status'] == 'update'
            ? todoController.dataList[m1['index']].notes
            : "");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade500,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: m1['status'] == 'update'
            ? Text(
                "Update your notes",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.blueGrey.shade50),
              )
            : Text(
                "Fill your notes",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.blueGrey.shade50),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextField(
                  style: TextStyle(color: Colors.blueGrey.shade500),
                  onTap: () {},
                  controller: txttitle,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      label: Text(
                        "Title",
                        style: TextStyle(color: Colors.blueGrey.shade500),
                      ),
                      focusColor: Colors.blueGrey.shade500,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey.shade500, width: 1)))),
              SizedBox(height: 10),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Obx(
                  () => DropdownButton(
                    value: todoController.selection.value,
                    items: todoController.proList.map(
                      (element) {
                        return DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                element,
                                style:
                                    TextStyle(color: Colors.blueGrey.shade500),
                              ),
                            ),
                            value: element);
                      },
                    ).toList(),
                    onChanged: (value) {
                      todoController.selection.value = value as String;
                    },
                    isExpanded: true,
                    elevation: 0,
                    focusColor: Colors.blueGrey.shade500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.watch_later,
                        color: Colors.blueGrey.shade500),
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                          context: Get.context!, initialTime: TimeOfDay.now());

                      todoController.t1.value =
                          todoController.changeTime(DateTime.now());
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueGrey.shade500)),
                      child: Obx(() => m1['status'] == 'update'
                          ? Text(
                              "${todoController.dataList[m1['index']].time}",
                              style: TextStyle(
                                  color: Colors.blueGrey.shade500,
                                  fontSize: 16),
                            )
                          : Text(
                              "${todoController.t1}",
                              style: TextStyle(
                                  color: Colors.blueGrey.shade500,
                                  fontSize: 16),
                            )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_month,
                        color: Colors.blueGrey.shade500),
                    onPressed: () async {
                      DateTime? pickDate = await showDatePicker(
                          context: Get.context!,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime(2024));

                      todoController.d1.value =
                          todoController.changeDate(pickDate!);
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueGrey.shade500)),
                      child: Obx(() => Text(
                            "${todoController.d1.value}",
                            style: TextStyle(
                                color: Colors.blueGrey.shade500, fontSize: 16),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              TextField(
                  style: TextStyle(color: Colors.blueGrey.shade500),
                  onTap: () {},
                  controller: txtnotes,
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      label: Text(
                        "Notes",
                        style: TextStyle(color: Colors.blueGrey.shade500),
                      ),
                      focusColor: Colors.blueGrey.shade500,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey.shade500, width: 1)))),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  TodoModal todomodal = TodoModal(
                      time: '${todoController.t1}',
                      priority: todoController.selection.value,
                      notes: txtnotes.text,
                      date: '${todoController.d1}',
                      title: txttitle.text);

                  if (m1['status'] == 'update') {
                    todoController.dataList[m1['index']] = todomodal;
                  } else {
                    todoController.dataList.add(todomodal);
                  }
                  Get.back();
                },
                child: m1['status'] == 'update'
                    ? Text(
                        "Update Data",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    : Text(
                        "Add Data",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
