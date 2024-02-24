import 'package:dio/dio.dart';
import 'package:first_app/screens/add.dart';
import 'package:first_app/screens/delete.dart';
import 'package:first_app/screens/single.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  bool isLoading = true;
  List<dynamic> blogs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState(); // runs before the framework builds(page reolads)
    getData(); //calling the function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MockApi CRUD'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading //ternary operator
          ? Center(
              //run this if isLoading is true
              child: CircularProgressIndicator(),
            )
          // body: Column(
          //   children: [
          //     Text("This is text"),
          //     Text("This is text"),
          //   ],
          // ),

          // body: Row(
          //   children: [
          //     Text("This is text"),
          //     Text("This is text"),
          //   ],
          // ),

          // body: ListView.builder(
          //     //ListView works as column but with scroll
          //     itemCount: 8,
          //     itemBuilder: (context, index) {
          //       //itemBulder loop through the list
          //       return ListTile(
          //         title: Text('$index render'),
          //       );
          //     }),
          //              //run this if isLoading is false
          /*body*/ : ListView.builder(
              //ListView works as column but with scroll
              // itemCount: 10
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                //itemBulder loop through the list
                final blog = blogs[index];
                final id = blog['id'];
                final avatar = blog['avatar'];
                final title = blog['name'];
                final description = blog['description'];

                return ListTile(
                  onTap: () {
                    // navigateToNextPageId(context, id);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SingleScreen(id)));
                  },

                  // leading: Icon(Icons.account_circle),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                  ),

                  // title: Text('Avatar $index'),
                  title: Text('$title'),

                  // subtitle: Text('This is subtitle'),
                  subtitle: Text(
                    '$description',
                    maxLines: 3,
                  ),

                  // trailing: Icon(Icons.edit, size: 20.0),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.edit),
                  //   iconSize: 20.0,
                  //   color: Color.fromRGBO(0, 255, 0, .5),
                  //   onPressed: () {
                  //     print('Edit button pressed');
                  //   },
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        onPressed: () => {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('IconButton clicked!'),
                          )),
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, size: 20),
                        onPressed: () async {
                          var data = await showDialog(
                              context: context,
                              builder: (_) => DeleteDialog(blog));
                          if (data == true) {
                            setState(() {
                              blogs.remove(blog);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await showDialog(
              context: context, builder: (_) => AddBlogState());
          if (data == null) return;
          //checking if data is added or not and returning empty if not

          setState(() {
            blogs.insert(0, data);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToNextPageId(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SingleScreen(id)));
  }

  void getData() async {
    var response =
        await dio.get('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test');
    //we dont use http its abit compex so we use Dio package
    // print(response);
    if (response.statusCode == 200) {
      setState(() {
        //notifies the ui to rebuild: makes app responsive/dynamic
        isLoading = false;
        blogs = response.data;
      });
    }
  }
}
