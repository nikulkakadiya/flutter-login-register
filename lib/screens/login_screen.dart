import 'dart:convert';
import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register/screens/home_screen.dart';
import 'package:login_register/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

String em="";
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formkey=GlobalKey<FormState>();

  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();

  _login() async {
    String s="login/";
    String s1=emailController.text;
    String s2=passwordController.text;

    String t=s+s1+"/"+s2;

    var res=await CallApi().getData(t);
    var body=json.decode(res.body);
    if(body['success']){


      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('stringValue', s1);

      });
      HomeScreen().getEmail();
      Fluttertoast.showToast(
          msg: 'Login success :',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      print("login");
    }else{
      Fluttertoast.showToast(
          msg: "user and password wrong :",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print("not login");
    }
  }

  @override
  Widget build(BuildContext context) {


    //email field
    final emailField=TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,

      validator: (value) => EmailValidator.validate(value!)
          ? null
          : "Please enter a valid email",

      onSaved: (value){
        emailController.text=value!;
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
      controller: passwordController,
      obscureText: true,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },

      onSaved: (value){
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //login button
    final loginButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          if(_formkey.currentState!.validate()){
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            _login();
            emailController.clear();
            passwordController.clear();

          }

        },
        child: Text("Login",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formkey,
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
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don`t have an account?"),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));

                          },
                          child: Text("SingUp",
                            style: TextStyle(
                              color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                        )
                      ],
                    )
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
