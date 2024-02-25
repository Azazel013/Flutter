import 'package:flutter/material.dart';

class ButtonClick extends StatefulWidget {
  const ButtonClick({super.key});

  @override
  State<ButtonClick> createState() => _ButtonClickState();
}

class _ButtonClickState extends State<ButtonClick> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Exercises",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
            ),
            Center(
              child: FloatingActionButton(
                // onPressed: () => {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('Krishna Dahal'),
                //     ),
                //   ),
                // },
                onPressed: () {
                  setState(() {
                    count = count + 1;
                  });
                },
                child: Icon(Icons.add),

                // focusColor: Colors.amber,
                hoverColor: Colors.amber,
              ),
            ),
            Text("${count}"),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    count = count > 0 ? count - 1 : 0;
                  });
                },
                child: Text("-"),
                hoverColor: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
