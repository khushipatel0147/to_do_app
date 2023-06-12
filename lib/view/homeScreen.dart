import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/contoller/todoController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TodoController todoController = Get.put(TodoController());

class _HomeScreenState extends State<HomeScreen> {

  @override
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      init: TodoController(),
      builder: (controller) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade500,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Store Data",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.blueGrey.shade50),
          ),
          actions: [
            IconButton(onPressed: () {
              Get.toNamed('/loc');
            }, icon: Icon(Icons.location_on,color:Colors.white,size: 20,))
          ],
        ),
        backgroundColor: Colors.blueGrey.shade50,
        body: Obx(
          () => GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    Get.toNamed('/data',arguments: {'status':'update','index':index});


                  },
                  onDoubleTap: () {
                    todoController.dataList.removeAt(index);
                  },
                  child: Container(
                    height: 150,
                    width: 200,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                "${controller.dataList[index].title}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: todoController
                                                .dataList[index].priority ==
                                            "Low"
                                        ? Colors.green
                                        : todoController
                                                    .dataList[index].priority ==
                                                "Medium"
                                            ? Colors.yellow
                                            : Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    "${controller.dataList[index].priority}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 1,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "--> ${controller.dataList[index].notes}",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 1,
                                color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                "${controller.dataList[index].date}",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 1,
                                    color: Colors.black),
                              ),
                              Spacer(),
                              Text(
                                "${controller.dataList[index].time}",
                                style: TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 1,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: controller.dataList.length),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/data',arguments: {'status':'add'});
            },
            backgroundColor: Colors.blueGrey.shade500,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            )),
      )),
    );
  }
}
