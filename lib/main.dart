import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodoapp/boxs.dart';
import 'package:mytodoapp/model/todo.dart';
import 'package:mytodoapp/screen/add_list.dart';
import 'package:mytodoapp/screen/homepage.dart';

void main() async{

 await Hive.initFlutter();
 
 Hive.registerAdapter(TodoAdapter());
 

 await Hive.openBox<Todo>(Boxes.todo);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

     
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
