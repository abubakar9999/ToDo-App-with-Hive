import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodoapp/boxs.dart';
import 'package:mytodoapp/screen/add_list.dart';

import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

TextEditingController searchData=TextEditingController();
List<Todo> todo= [];
Box<Todo>? box;




@override
  void initState() {
    if(Hive.box<Todo>(Boxes.todo).isNotEmpty){
    todo= Hive.box<Todo>(Boxes.todo).values.toList();
    print(todo.length);
    }

    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    Hive.close();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Your Task")),
        body: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchData,

              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                    hintText: "search your Item",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.yellow)
                    
                    )

              ),
              onChanged:serchTask

              
            ),
          ),
            Expanded(
              child: 
                  ListView.builder(
                  itemCount: todo.length,
                  
                  itemBuilder: (context,index){
                    // Todo? data=box.getAt(index);
                    return Dismissible(
                      key:UniqueKey() , 
                      background: Container(color: Colors.red),
                      onDismissed: ((direction) {
                      setState(() {
                         todo.clear();
                      });
                     
                      }),
                    child: Card(
                      child: ListTile(
                        title: Text(todo[index].title.toString()),
                        subtitle: Text(todo[index].discrib.toString()),
                        ),
                    ),
                      );
    
                 })
                 
                 
    
                  
            ),
          ],
        ),
    
            floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToList()));
    
              
            },
            tooltip: "add",
            child: Icon(Icons.add),
            
            ),
          
        
    
        
      ),
    );
    
  }

  void serchTask(String query){
    final sugation= todo.where((element){
      final serchinlist=element.title!.toLowerCase();
      final input=query.toLowerCase();
      return serchinlist.contains(input);
    }).toList();

    setState(() {
      todo=sugation;
    });
  }

  
}