import 'dart:convert';

import 'package:http/http.dart';
import 'package:network_request_demo2/const.dart';
import 'package:network_request_demo2/model/user.dart';

class UserService{
  static var shared=UserService();
 Future<List<User>> fetchUser({int page,int limit= TOTALPAGEITEM})  async {
    List<User> users=[];
    try{
    final String url=APIBASEURL +"users?page="+page.toString()+"&limit=" +limit.toString();
   var response=await  get(url);
   if(response.statusCode==200){
     List<dynamic> arrayjson=jsonDecode(response.body);
     for(var json in arrayjson){
       var user=User.fromJSON(json);
       users.add(user);
     }
 return users;
   }else{
        return null;
   }
  
    }catch(e){
      return users;
    }
}
}