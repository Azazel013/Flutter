import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditBlog extends StatefulWidget {
  final blog;
  final Function() refreshData;
  const EditBlog(this.blog, this.refreshData);

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final dio = Dio();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final avatarController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.blog['name'];
    descriptionController.text = widget.blog['description'];
    avatarController.text = widget.blog['avatar'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Blog'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Image(
              height: 50,
              width: 50,
              image: NetworkImage(widget.blog['avatar']),
            ),
            Text(widget.blog['name']),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter Title',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description',
              ),
              maxLines: 2,
            ),
            TextFormField(
              controller: avatarController,
              decoration: InputDecoration(
                labelText: 'Avatar',
                hintText: 'Enter Avatar',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              // print("object");
              editData({
                'name': titleController.text,
                'description': descriptionController.text,
                'avatar': avatarController.text,
              });
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void editData(Map data) async {
    var response = await dio.put(
        'https://65d595adf6967ba8e3bbdc6c.mockapi.io/test/${widget.blog['id']}',
        data: data);
    if (response.statusCode == 200) {
      Navigator.pop(context, response.data);
      widget.refreshData();
    }
    setState(() {
      // isLoading = true;
    });
  }
}
