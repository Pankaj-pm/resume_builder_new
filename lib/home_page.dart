import 'package:flutter/material.dart';
import 'package:resume_builder_new/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawer(
          children: buildOption.map((e) {
        return ListTile(
          title: Text(
            e["name"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onTap: () {

            
          },
          leading: Image.asset("images/icons/${e["icon"]}"),
        );
      }).toList()),
      // drawerScrimColor: Colors.red,
    );
  }
}
