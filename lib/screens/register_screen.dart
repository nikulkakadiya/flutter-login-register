import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_register/screens/api.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey=GlobalKey<FormState>();

  final firstNameEditingController=new TextEditingController();
  final seconfNameEditingController=new TextEditingController();
  final emailEditingController=new TextEditingController();
  final passwordEditingController=new TextEditingController();
  final confirmPasswordEditingController=new TextEditingController();

  _register() async {
    var data={
      'fname':firstNameEditingController.text,
      'lname':seconfNameEditingController.text,
      'email':emailEditingController.text,
      'pass':passwordEditingController.text,
      'confpass':confirmPasswordEditingController.text

    };
    var res=await CallApi().postData(data,"register");
    var body=json.decode(res.body);

    if(body['success']){
      print('insert :');
    }else{
      print('not insert');
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {

    //first name field
    final firstNameField=TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,

      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please Enter Name';
        }
        return null;
      },

      onSaved: (value){
        firstNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    //second name field
    final secondNameField=TextFormField(
      autofocus: false,
      controller: seconfNameEditingController,
      keyboardType: TextInputType.name,

      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please Enter Name';
        }
        return null;
      },

      onSaved: (value){
        seconfNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //email field
    final emailField=TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,

      validator: (value) => EmailValidator.validate(value!)
          ? null
          : "Please enter a valid email",

      onSaved: (value){
        emailEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField=TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },

      onSaved: (value){
        passwordEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //confirmPasswordField
    final confirmPasswordField=TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },

      onSaved: (value){
        confirmPasswordEditingController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //signing button
    final signUpButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){

          if(_formKey.currentState!.validate()){
            print("this is ohk page");
            _register();
            firstNameEditingController.clear();
            seconfNameEditingController.clear();
            emailEditingController.clear();
            passwordEditingController.clear();
            confirmPasswordEditingController.clear();
          }else{
            print("this is not ohk page");
          }
        },
        child: Text("SignUp",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),

      // backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/food.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    firstNameField,

                    SizedBox(height: 20),
                    secondNameField,

                    SizedBox(height: 20),
                    emailField,

                    SizedBox(height: 20),
                    passwordField,

                    SizedBox(height: 20),
                    confirmPasswordField,

                    SizedBox(height: 20),
                    signUpButton,

                    SizedBox(height: 10),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
