import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stateful_app/details.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  _MyFormState(){
    _selectedVal =_productSizesList[0];
  }
  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  final _productSizesList = ["10", "12", "B.Tech", "M.Tech"];
  String _selectedVal = ".";

  // late DatabaseReference dbref;
  @override
  void initState() {
    super.initState();
    // dbref = FirebaseDatabase.instance.ref().child('Students');
  }

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade300,
            title: const Text("Form"),
            centerTitle: true),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              MyTextField(
                  myController: _productController,
                  fieldName: "Product Name",
                  myIcon: Icons.account_balance,
                  prefixIconColor: Colors.deepPurple.shade300),
              const SizedBox(height: 10.0),
              //Use to add space between Textfields
              MyTextField(
                  myController: _productDesController,
                  fieldName: "Product Description",
                  prefixIconColor: Colors.deepPurple.shade300),
              const SizedBox(height: 10.0,),
              DropdownButtonFormField(
                value: _selectedVal,
                items: _productSizesList.map(
                        (e){
                      return DropdownMenuItem(child: Text(e), value: e,);
                    }
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal= val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.deepPurple,
                ),
                dropdownColor: Colors.deepPurple.shade50,
                decoration: InputDecoration(
                    labelText: "Education",
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20.0),
              myBtn(context),
            ],
          ),
        ));
  }

  //Function that returns OutlinedButton Widget also it pass data to Details Screen
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () async {
        Map<String, String> students = {
          'name': _productController.text,
          'age': _productDesController.text,
          'size': _selectedVal.toString()
        };
        CollectionReference users =
        FirebaseFirestore.instance.collection('users');
        await users.doc(_productController.text).set({
          //Data added in the form of a dictionary into the document.
          'name': _productController.text,
          'age': _productDesController.text,
          'size': _selectedVal.toString(),
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
            Details()),
          );
        });
      },
      child: Text(
        "Submit Form".toUpperCase(),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }
}

//Custom STateless WIdget Class that helps re-usability
// You can learn it in Tutorial (2.13) Custom Widget in Flutter
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  });

  final TextEditingController myController;
  String fieldName;
  final IconData myIcon;
  Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
    );
  }
}

