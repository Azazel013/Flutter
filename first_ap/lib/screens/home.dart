import 'package:dio/dio.dart';
import 'package:first_ap/screens/delete.dart';
import 'package:first_ap/screens/single.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final dio = Dio();
  List<dynamic> blogs = [];
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MockApi CRUD'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                final id = blog['id'];
                final avatar = blog['avatar'];
                final title = blog['name'];
                final descrtiption = blog['description'];
                return ListTile(
                  onTap: () {
                    navigateToNextPageId(context, id);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                  ),
                  title: Text("$title"),
                  subtitle: Text("$descrtiption", maxLines: 3),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        onPressed: () {
                          print('Edit');
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        onPressed: () async {
                          var data = await showDialog(
                              context: context,
                              builder: (_) => DeleteDialog(blog));
                          if (data == true) {
                            setState(() {
                              blogs.remove(blog);
                            });
                          }
                          print('Delete');
                        },
                      ),
                    ],
                  ),
                );
              }),
    );
  }

  void getData() async {
    var response =
        await dio.get('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test');
    // print(response.data);

    setState(() {
      isLoading = false;
      blogs = response.data;
    });
  }

  void navigateToNextPageId(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SingleScreen(id)));
  }
}
