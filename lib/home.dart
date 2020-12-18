import 'package:flutter/material.dart';
import 'package:network_request_demo2/const.dart';
import 'package:network_request_demo2/model/user.dart';
import 'package:network_request_demo2/service/user_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users=[];
  bool _isLoading=false;
  bool _nomoreitem=false;
  int _page=1;
  ScrollController _scrollcontroller;
  //https://5b5cb0546a725000148a67ab.mockapi.io/api/v1/users?page=5&limit=25

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=true;
    fetchUser();
    _scrollcontroller=ScrollController();
    _scrollcontroller.addListener(() {
       print(_scrollcontroller.position.pixels);
      print(_scrollcontroller.position.maxScrollExtent);
      if(!_nomoreitem && _scrollcontroller.position.pixels>(_scrollcontroller.position.maxScrollExtent-30))
      {
        setState(() {
           _isLoading=true;
        _page++;
        fetchUser();
        });
       
      }
      
    });
  }

  fetchUser(){
    var userFuture=UserService.shared.fetchUser(page: _page);
    userFuture.then((users){
      setState(() {
      
         _users.addAll(users);
          _isLoading=false;
      });
     
      if(users.length<TOTALPAGEITEM) 
        _nomoreitem=true;
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Network Calling"),backgroundColor: Colors.green,),
      body: 
         Stack(
            children: [
              ListView.builder(
                 controller:_scrollcontroller,
                itemBuilder: (context,index){
                return Card(child: ListTile(title: Text("${index+1} .${_users[index].name}",)),);
              },
              itemCount: _users.length,
              ),
               if(_isLoading) Center(child: Container(child: CircularProgressIndicator(),),)
            ],
          ),
        
       
      
    );
  }
}
// "id": "91",
//         "createdAt": "2019-02-16T15:32:10.913Z",
//         "name": "Mrs. Turner Schaden",
//         "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/jqiuss/128.jpg"

