// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import '../../../components/already_have_an_account_acheck.dart';
//import '../../../constants.dart';
//import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim());
    var User = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(User?.uid).set({
      "First Name": _fNameController.text.trim(),
      "Last Name": _lNameController.text.trim(),
      "Email": _emailController.text.trim(),
    });
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Register! ",
                          style: TextStyle(
                              fontSize: screenWidth * 0.15,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: SizedBox(
                              child: TextFormField(
                                controller: _fNameController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'First Name cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: SizedBox(
                              child: TextFormField(
                                controller: _lNameController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Last Name cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          validator: (text) =>
                              isValidEmail(text!) ? null : "Enter valid email",
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),
                      
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),
                       
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: _confirmPassController,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Confirm Password cannot be empty';
                            }
                            if (_passController.text.trim() !=
                                _confirmPassController.text.trim()) {
                              return 'Passwords don\'t match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),
                       
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                signUp();
                              }
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                child: Center(
                                    child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
