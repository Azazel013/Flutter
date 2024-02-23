import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final blog;
  DeleteDialog(this.blog);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Blog'),
      content: Text('Are you sure you want to delete this blog?'),
      actions: [
        //TextButton(onPressed: () {}, child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            deleteBlog(widget.blog['id']);
          },
          child: Text('Delete'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void deleteBlog(String id) async {
    var response = await dio
        .delete('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test/${id}');
    if (response.statusCode == 200) {
      Navigator.pop(context, true);
    }
  }
}
