import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBlogState extends StatefulWidget {
  AddBlogState({super.key});

  @override
  State<AddBlogState> createState() => _AddBlogStateState();
}

class _AddBlogStateState extends State<AddBlogState> {
  bool isLoading = false;
  final dio = Dio();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final avatarController = TextEditingController();
  //types of controller:textEditing,scrollEditing,every controller has listner
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    avatarController.dispose();
    super.dispose();
  }
  //we are using dispose function to clear memory:only in stateFul widget

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Blog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        //top to down main axis:left to right cross axis in column
        //left to right main axis: top to down cross axis in Row
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          TextFormField(
            controller: avatarController,
            decoration: InputDecoration(labelText: 'Avatar'),
          ),
          SizedBox(
            height: 20,
            width: 20,
          )
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                var data = {
                  "name": nameController.text,
                  "description": descriptionController.text,
                  "avatar": avatarController.text,
                };

                addData(data);
                //we cant do await because the function is null we can use future to await it
              },
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Text('Add')),
        )
      ],
    );
  }

  void addData(Map data) async {
    setState(() {
      isLoading = true;
    });
    var response = await dio
        .post('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test', data: data);
    if (response.statusCode == 201) {
      Navigator.pop(context, response.data); //we're sending data here
    }
    // setState() {
    //   // isLoading = false;
    // }
  }
}

//global position
//nav bar,floatting
