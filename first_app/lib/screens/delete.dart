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
      title: Center(child: Text('delete')),
      content: Text('this is sontent ${widget.blog['name']}'),
      actions: [
        ElevatedButton(
            onPressed: () => deleteData(widget.blog['id']),
            child: Text('delete')),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('cancel'))
      ],
    );
  }

  void deleteData(String id) async {
    try {
      var response = await dio
          .delete('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test/${id}');
      if (response.statusCode == 200) {
        Navigator.pop(context, true);
        //checks in onpreseed async func data==true
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
