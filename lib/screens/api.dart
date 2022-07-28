import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CallApi{
  final String _url="http://192.168.1.5:8080/";
  // final String _url="http://192.168.137.1:8080/";

  postData(data,apiurl) async {
    var fullurl=_url+apiurl;
    return await http.post(
      Uri.parse(fullurl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json'
  };

  getData(String t) async {
    var fullurl=_url+t;
    return await http.get(
      Uri.parse(fullurl),
      headers: _setHeaders(),
    );
  }
}