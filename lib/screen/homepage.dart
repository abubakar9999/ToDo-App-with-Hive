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
            Text("abubjsdf"),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Todo>(Boxes.todo).listenable(),
                builder: ( context, Box<Todo> box, _) {
                 if(box.values.isEmpty){
                  return Text("Your ToDo is Empty");
                  
                 } 
                 return ListView.builder(
                  itemCount: box.values.length,
                  
                  itemBuilder: (context,index){
                    Todo? data=box.getAt(index);
                    return Dismissible(
                      key:UniqueKey() , 
                      background: Container(color: Colors.red),
                      onDismissed: ((direction) {
                      setState(() {
                          box.deleteAt(index);
                      });
                     
                      }),
                    child: Card(
                      child: ListTile(
                        title: Text(data!.title.toString()),
                        subtitle: Text(data.discrib.toString()),
                        ),
                    ),
                      );
    
                 });
                 
                 }
    
                  ),
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
}