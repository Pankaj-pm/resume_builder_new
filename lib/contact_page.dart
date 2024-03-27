import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String? maritalStatus;
  bool isEn = false;
  bool isHi = false;
  bool isGu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DOB"),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text("Marital Status"),
            Row(
              children: [
                Radio(
                    value: "single",
                    fillColor: MaterialStatePropertyAll(Colors.red),
                    hoverColor: Colors.pink,
                    groupValue: maritalStatus,
                    onChanged: (val) {
                      maritalStatus = val;
                      setState(() {});
                      print(val);
                    }),
                Text("Single"),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: "married",
                    groupValue: maritalStatus,
                    onChanged: (val) {
                      maritalStatus = val;
                      setState(() {});
                      print(val);
                    }),
                Text("Married"),
              ],
            ),
            RadioListTile(
              value: "single",
              // overlayColor: MaterialStatePropertyAll(Colors.yellow),
              hoverColor: Colors.pink,
              fillColor: MaterialStatePropertyAll(Colors.yellow),
              tileColor: Colors.yellow,
              groupValue: maritalStatus,
              onChanged: (value) {
                maritalStatus = value;
                setState(() {});
              },
              title: Text("Single"),
            ),
            Checkbox(
              value: isEn,
              onChanged: (val) {
                isEn = val ?? false;
                setState(() {});
                print("$val");
              },
            ),
            Checkbox(
              value: isHi,
              onChanged: (val) {
                isHi = val ?? false;
                setState(() {});
                print("$val");
              },
            ),
            Checkbox(
              value: isGu,
              fillColor: MaterialStatePropertyAll(Colors.red),
              onChanged: (val) {
                isGu = val ?? false;
                setState(() {});
                print("$val");
              },
            ),
            CheckboxListTile(
              value: isHi,
              title: Text("Hindi"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) {
                isHi = val ?? false;
                setState(() {});
                print("$val");
              },
            ),
            Switch(value: isEn, onChanged: (value) {
              isEn=value;
              setState(() {

              });
            },)
          ],
        ),
      ),
    );
  }
}
