import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String em="";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  State<HomeScreen> createState() => _HomeScreenState();

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    em = prefs.getString('stringValue').toString();
    print(em);
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,

      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/food.jpg",fit: BoxFit.contain,),
              ),

              Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                '${em}',
                style: TextStyle(
                    color:Colors.black54,
                  fontWeight: FontWeight.w500
                ),
              ),

              SizedBox(height: 15,),
              ActionChip(label: Text("Log-Out"),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('stringValue');
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));

                  Fluttertoast.showToast(
                      msg: 'Log-out :',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
