import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/modal/todoModal.dart';
import 'package:intl/intl.dart';

class TodoController extends GetxController {
  RxList<TodoModal> dataList = <TodoModal>[
    TodoModal(
        title: "Zudio",
        des: "Shooping time",
        date: "05/06/2023",
        notes: "45K limited on this shopping",
        priority: "Low",
        time: "5 o'clock"),
    TodoModal(
        title: "Mackup",
        des: "Beauty time",
        date: "04/06/2023",
        notes: "25K limited on this mackup",
        priority: "Medium",
        time: "3 o'clock"),
    TodoModal(
        title: "Gold",
        des: "Jwellery time",
        date: "03/06/2023",
        notes: "3 lakh on this gold",
        priority: "High",
        time: "6 o'clock"),
  ].obs;

  RxString d1 = '${DateTime.now()}'.obs;
  RxString t1 = '${TimeOfDay.now()}'.obs;
  RxList proList = ['Low', 'Meduim', 'High'].obs;
  RxString selection = 'Low'.obs;

  String changeDate(DateTime dt) {
    var change = DateFormat('dd-MM-yyyy');
    return change.format(dt);
  }

  String changeTime(DateTime time1)
  {
    var change=DateFormat('HH:mm a');
    return change.format(time1 );
  }
}
