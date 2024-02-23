import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleScreen extends StatefulWidget {
  final String id; //final values should be assigned at constructor
  SingleScreen(this.id); //assigining here

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  final dio = Dio();
  dynamic blogData = {};
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Page'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: [
                  Image(
                      height: 250,
                      width: 250,
                      image: NetworkImage(blogData['avatar'] ?? 'nodata')),
                  Text(blogData['name'] ?? 'No data'),
                  Text(blogData['description'] ?? 'nodata')
                ],
              ),
            ),
    );
  }

  void getData(String id) async {
    var response =
        await dio.get('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test/${id}');
    print(response.data);
    setState(() {
      //notifies the ui to rebuild makes app responsive/dynamic
      isLoading = false;
      blogData = response.data;
    });
  }
}
