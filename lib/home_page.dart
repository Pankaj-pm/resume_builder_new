import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_builder_new/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        systemNavigationBarColor: Colors.red,
        systemNavigationBarDividerColor: Colors.red,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      drawer: NavigationDrawer(
          children: buildOption.map((e) {
        return ListTile(
          title: Text(
            e["name"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onTap: () {
            Navigator.pushNamed(context, e["page"] ?? "");
          },
          leading: Image.asset("images/icons/${e["icon"]}"),
        );
      }).toList()),
      body: Center(child: Text("No Resumes + Create new resume.")),
      floatingActionButton: FloatingActionButton(onPressed: () {

      },child: Icon(Icons.add),),
      // drawerScrimColor: Colors.red,
    );
  }
}
