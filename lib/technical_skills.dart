import 'package:flutter/material.dart';
import 'package:resume_builder_new/util.dart';

class TechnicalSkills extends StatefulWidget {
  const TechnicalSkills({super.key});

  @override
  State<TechnicalSkills> createState() => _TechnicalSkillsState();
}

class _TechnicalSkillsState extends State<TechnicalSkills> {
  List<TextEditingController> skillList = [];

  @override
  void initState() {
    super.initState();
    for (var element in resume.mySkill) {
      skillList.add(TextEditingController(text: element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black12,
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Enter your skills"),
              Column(
                children: skillList.map((e) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: e,
                          decoration: InputDecoration(hintText: "Skill"),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          skillList.remove(e);
                          setState(() {

                          });
                        },
                        child: Icon(Icons.delete),
                      )
                    ],
                  );
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    skillList.add(TextEditingController());
                    print("skillList.length => ${skillList.length}");
                    setState(() {});
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resume.mySkill.clear();
          for (var element in skillList) {
            resume.mySkill.add(element.text);
            print(element.text);
          }
          print("Press");
        },
      ),
    );
  }
}
