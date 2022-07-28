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
  Box<Todo> contactBox = Hive.box<Todo>(Boxes.todo);

  TextEditingController searchData = TextEditingController();
  List<Todo> todo = [];
  Box<Todo>? box;
  List foundUsers=[];

  @override
  void initState() {
    if (Hive.box<Todo>(Boxes.todo).isNotEmpty) {
      todo = Hive.box<Todo>(Boxes.todo).values.toList();
      print(todo.length);
    }
   
    setState(() {
       foundUsers =todo;
    });

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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.yellow))),
                  onChanged: (value) {
                    runFilter(value);
                    // serchTask(value);
                  }),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: foundUsers.length,
                    itemBuilder: (context, index) {
                      // Todo? data=box.getAt(index);
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(color: Colors.red),
                        onDismissed: ((direction) {
                          contactBox.deleteAt(index);
                        }),
                        child: Card(
                          child: ListTile(
                            title: Text(foundUsers[index].title.toString()),
                            subtitle: Text(foundUsers[index].discrib.toString()),
                          ),
                        ),
                      );
                    })),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddToList()));
          },
          tooltip: "add",
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void runFilter(String enteredKeyword) {
    //todo foundUser is emti List
    foundUsers = todo;
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = foundUsers;
    } else {
      var starts = foundUsers
          .where((s) =>
              s.title.toLowerCase().startsWith(enteredKeyword.toLowerCase()))
          .toList();

      var contains = foundUsers
          .where((s) =>
              s.title.toLowerCase().contains(enteredKeyword.toLowerCase()) &&
              !s.title.toLowerCase().startsWith(enteredKeyword.toLowerCase()))
          .toList()
        ..sort((a, b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()));

      results = [...starts, ...contains];
    }
      // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }

  
     
    


    
  


}
