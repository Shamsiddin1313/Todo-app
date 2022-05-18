import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/task/selected.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key, this.activity}) : super(key: key);
  final String? activity;
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final controller = TextEditingController();

  List<Task> data = [];

  void clearText() {
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference items = FirebaseFirestore.instance.collection('items');

    Future<void> activity() {
      return items
          .add({'items': widget.activity})
          .then((value) => print("Activity Added"))
          .catchError((onError) => print("Failed to add activity: $onError"));
    }

    CollectionReference things =
        FirebaseFirestore.instance.collection('things');

    Future<void> updateActivity() async {
      return things
          .doc()
          .update({'things': widget.activity})
          .then((value) => print("User updated"))
          .catchError((onError) => print('Failed to update item: $onError'));
    }

    CollectionReference doings =
        FirebaseFirestore.instance.collection('things');

    Future<void> deleteActivity() async {
      return doings
          .doc()
          .delete()
          .then((value) => print("User deleted"))
          .catchError((onError) => print('Failed to update item: $onError'));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 48, top: 48),
            padding: const EdgeInsets.only(right: 15),
            color: Colors.white,
            height: 80,
            width: 250,
            child: Center(
              child: Text(
                "Task to do ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                    color: Colors.grey.shade600),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: GestureDetector(
                  onTap: () {
                    updateActivity();
                    activity();
                    clearText();
                    setState(() {});
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.purple.shade200,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "Add New Task",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple.shade200),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: TextField(
              autofocus: true,
              onChanged: (value) {},
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Enter Something", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        height: 50,
                        width: 50,
                        child: IconButton(
                          icon: data[index].isSelected == true
                              ? const Icon(Icons.done_rounded)
                              : const Icon(null),
                          onPressed: () {
                            data[index].isSelected = !data[index].isSelected;

                            setState(() {});
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: BorderRadius.circular(10),
                            color: data[index].isSelected == true
                                ? Colors.blue
                                : Colors.white),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        data[index].name!,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          decoration: data[index].isSelected == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          deleteActivity();
                          updateActivity();
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: data.length)
        ],
      )),
    );
  }
}
