import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String _nacionality = "";
  String _education = "sup";
  double _currentSlideValue = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Hello, be welcome!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Text("First Name and Surname", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(109, 218, 205, 1.0)
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please, input the information";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Text("E-mail:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(109, 218, 205, 1.0)
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please, input an e-mail";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Text("Create a password:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(109, 218, 205, 1.0)
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please, input a password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 45),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(315, 66)),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(218, 109, 143, 1.0)),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic)),
                    ),
                    onPressed: () {
                      // Ação do botão "Create account"
                    },
                    child: Text("Create account"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
