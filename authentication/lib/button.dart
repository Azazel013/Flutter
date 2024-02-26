import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:authentication/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonState();
}

class _ButtonState extends State<ButtonWidget> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  final dio = Dio();
  dynamic token = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('login')),
        foregroundColor: Colors.white,
        backgroundColor: Colors.amberAccent,
      ),
      body: Form(
        key: key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'email'),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "email is required";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'password'),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "password is required";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        var formData = {
                          "email": emailController.text,
                          "password": passwordController.text
                        };
                        Login(formData);
                      }
                    },
                    child: Text('login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Login(Map formData) async {
    try {
      var response =
          await dio.post("https://reqres.in/api/login", data: formData);
      if (response.statusCode == 200) {
        _prefs
            .then((value) => value.setString("token", response.data['token']));
        print(response.data['token']);

        Route route = MaterialPageRoute(builder: (context) => Home());
        Navigator.pushReplacement(context, route);
      }
    } catch (e) {
      print(e);
    }
  }
}
