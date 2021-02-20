//ไฟล์นี้เอาไว้เขียนโค้ดเรียกใช้ Service ต่างๆ ที่ Server
import 'dart:convert';

import 'package:flutter_app_ep3/models/myaccount.dart';
import 'package:http/http.dart' as http;

String urlService = "http://172.17.32.14";

Future<List<MyAccount>> serviceGetAllMyAccount() async{
  final response = await http.get(
    Uri.encodeFull('${urlService}/accountdiary/serviceGetAllMyAccount.php'),
    headers: {"Content-Type": "application/json"},
  );

  if(response.statusCode == 200){
    final responseData = jsonDecode(response.body);
    final myaccountData = await responseData.map<MyAccount>((json){
      return MyAccount.fromJson(json);
    }).toList();
    return myaccountData;

  }else{
    return null;
  }
}
