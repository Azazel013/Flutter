import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  bool isLoading = false;
  final dio = Dio();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final avatarController = TextEditingController();
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Blog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Enter Description',
            ),
            maxLines: 2,
          ),
          TextField(
            controller: avatarController,
            decoration: InputDecoration(
              labelText: 'Avatar',
              hintText: 'Enter Avatar',
            ),
          ),
        ],
      ),
      actions: [
        // IconButton(onPressed: () {}, icon: Center(child: Icon(Icons.save))),
        ElevatedButton(
          onPressed: () {
            var data = {
              'name': nameController.text,
              'description': descriptionController.text,
              'avatar': avatarController.text,
            };
            addData(data);
            // print(data);
            // Navigator.pop(context); // Close the dialog
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(child: Text('Add')),
        ),
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
      Navigator.pop(context, response.data);
    }
  }
}
