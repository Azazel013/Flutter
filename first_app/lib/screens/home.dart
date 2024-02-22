import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final dio = Dio();
  List<dynamic> blogs = [];
  @override
  void initState() {
    //initState is already in the state class
    // TODO: implement initState
    super.initState(); // rus before the framework builds(page reolads)
    getData(); //calling the function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MockApi CRUD'),
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
                final blog = blogs[index];
                final avatar = blog['avatar'];
                final title = blog['name'];
                final description = blog['description'];

                //itemBulder loop through the list
                return ListTile(
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       'https://unsplash.random.com/200/200?sig=$index'),
                    // ),

                    // leading: Icon(Icons.account_circle),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('$avatar'),
                    ),

                    // title: Text('Avatar $index'),
                    title: Text('$title'),
                    // subtitle: Text('This is subtitle'),
                    subtitle: Text(
                      '$description',
                      maxLines: 3,
                    ),
                    // trailing: Icon(Icons.edit, size: 20.0),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 20.0,
                      color: Color.fromRGBO(0, 255, 0, .5),
                      onPressed: () {
                        print('Edit button pressed');
                      },
                    ));
              }),
    );
  }

  void getData() async {
    print(isLoading);
    var res = await dio.get('https://65d595adf6967ba8e3bbdc6c.mockapi.io/test');
    print(res);
    //we dont use http its abit compex so we use
    //Dio package
    if (res.statusCode == 200) {
      setState(() {
        //notifies the ui to rebuild makes app responsive/dynamic
        isLoading = false;
        blogs = res.data;
      });
      print(res.data);
      print(isLoading);
    }
  }
}
