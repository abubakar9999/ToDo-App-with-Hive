import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodoapp/boxs.dart';

import '../model/todo.dart';

class AddToList extends StatefulWidget {
  AddToList({Key? key}) : super(key: key);

  @override
  State<AddToList> createState() => _AddToListState();
}

class _AddToListState extends State<AddToList> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  late String titel;
  late String dis;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Add ToDo"),),

      body: SafeArea(
        child: Form(
          key: _globalKey,

          
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: <Widget>[

              TextFormField(
                autofocus: true,
                initialValue: "",
                onChanged: ((value) {
                 setState(() {
                   titel=value;
                 });
                  
                }),
                decoration: InputDecoration(
                  hintText: "Enter your titel"
                ),

                validator: (value) {
                  if(value!.isEmpty){
                    return"This is requard";

                  }
                  return null;
                },



              ),
              TextFormField(
               

                initialValue: "",
                onChanged: ((value) {
                 setState(() {
                  dis=value;
                 });
                  
                }),
                decoration: InputDecoration(
                  hintText: "your discribtion"
                ),

                validator: (value) {
                  if(value!.isEmpty){
                    return"This is requard";

                  }
                  return null;
                },



              ),

              ElevatedButton(onPressed: (){
                validate();
              }, child: Text("submit")),
              
            ],
        ),
          )),
      ),
    );
  }

  validate(){
    if(_globalKey.currentState!.validate()){
      putDatainHive();
       print("Form Validated");
    }else{
      print("Form Not Validated");
      return;
    }
  }

  putDatainHive(){
    Box<Todo> contactBox=Hive.box<Todo>(Boxes.todo);
    contactBox.add(Todo( discrib: dis,title: titel));
    Navigator.pop(context);
  }
}