import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_builder_new/my_pdf.dart';
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
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Text("ghjuads"),
          ),
          Container(
            child: Text(
              "Build",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
          ),
          ...buildOption.map((e) {
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
          }).toList()
        ],
      ),
      body: Column(
        children: [
          Text(
            "personal Detail",
            style: TextStyle(fontSize: 23),
          ),
          Text(
            "Name = ${resume.name}",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "Email = ${resume.name}",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "Phone = ${resume.name}",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "Address = ${resume.address1} ${resume.address2} ${resume.address3}",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "My Skill",
            style: TextStyle(fontSize: 23),
          ),
          Column(
            children: resume.mySkill.map((e) => Text("$e")).toList(),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return MyPdf();
          // },));

          Navigator.pushNamed(context, "myPdf");
        },
        child: Icon(Icons.add),
      ),
      // drawerScrimColor: Colors.red,
    );
  }
}
