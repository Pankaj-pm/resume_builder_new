// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder_new/util.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  int index = 0;

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  String userName = "";
  String email = "";
  bool isVisible = true;
  String? xFile;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = resume.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("personalDetails"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    index = 0;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    color: Color(0xff4591ea),
                    child: Text(
                      "Contact",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    index = 1;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    color: Color(0xff4591ea),
                    child: Text("Photo", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: index,
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2)]),
                    child: Form(
                      key: fKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: resume.name,
                                  // controller: emailController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    labelText: "Name",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(10),
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter your Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    userName = val;
                                    print("===> $val");
                                  },
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  // initialValue: resume.email,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                  ),
                                  // obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  keyboardAppearance: Brightness.dark,
                                  onFieldSubmitted: (value) {
                                    print("onFieldSubmitted $value");
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Your Email Address";
                                    } else if (!val.contains("@") || !val.contains(".com")) {
                                      return "Please Enter Valid Email Address";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.password),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: passController,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        isVisible = !isVisible;
                                        setState(() {});
                                      },
                                      child: Icon(Icons.remove_red_eye),
                                    ),
                                    // suffix: Icon(Icons.remove_red_eye),
                                  ),
                                  obscureText: isVisible,
                                  keyboardType: TextInputType.emailAddress,
                                  keyboardAppearance: Brightness.dark,
                                  onFieldSubmitted: (value) {
                                    print("onFieldSubmitted $value");
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone_android),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(hintText: "Phone"),
                                  keyboardType: TextInputType.phone,
                                  onSubmitted: (value) {},
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(hintText: "Address line 1"),
                                      onSaved: (val) {
                                        print("Address line 1 Save $val");
                                      },
                                    ),
                                    TextField(
                                      textInputAction: TextInputAction.search,
                                    ),
                                    TextField(),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      bool isValid = fKey.currentState?.validate() ?? false;

                                      if (isValid) {
                                        resume.name = userName;
                                        resume.email = email;
                                        fKey.currentState?.save();
                                        FocusScope.of(context).unfocus();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Saved")),
                                        );
                                      }
                                    },
                                    child: Text("Save")),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      emailController.text = "new Text";
                                      emailController.text = "";
                                      emailController.clear();

                                      // fKey.currentState?.reset();
                                    },
                                    child: Text("Reset")),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 300,
                  padding: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 2)]),
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: FileImage(File(xFile ?? "")),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () async {
                              XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
                              xFile = file?.path ?? "";
                              setState(() {});
                              print("image");
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: InkWell(
                            onTap: () async {
                              XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                              xFile = file?.path ?? "";
                              setState(() {});
                              print("image");
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                              child: Icon(Icons.photo),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
