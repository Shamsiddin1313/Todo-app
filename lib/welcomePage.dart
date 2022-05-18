import 'package:flutter/material.dart';
import 'package:todo/tasktodo.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: 80,
            width: 270,
            color: Colors.white,
            child: Text(
              "TaskDo",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                  fontSize: 72),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "Manage You Task Checklist Easily",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Todo()));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 145,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple.shade200),
              child: const Center(
                child: Text(
                  "Lets Start",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
