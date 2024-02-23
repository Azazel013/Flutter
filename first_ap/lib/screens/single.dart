import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SingleScreen extends StatefulWidget {
  final String id;
  SingleScreen(this.id);

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  bool isLoading = true;
  final dio = Dio();
  dynamic blogData = {};
  void initState() {
    super.initState();
    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Single Blog'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              children: [
                Image(
                  height: 200,
                  width: 200,
                  image: NetworkImage(blogData['avatar'] ?? 'no data'),
                ),
                Text(blogData['name'] ?? 'no data'),
                Text(blogData['description'] ?? 'no data'),
              ],
            )),
    );
  }

  void getData(String id) async {
    var response =
        await dio.get('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test/${id}');
    print(response.data);
    setState(() {
      isLoading = false;
      blogData = response.data;
    });
  }
}
