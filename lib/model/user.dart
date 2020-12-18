class User{
  String id;
  String creatAt;
  String name;
  String avator;
  User.fromJSON(Map<String,dynamic> json){
    id=json["id"];
    creatAt=json["createdAt"];
    name=json["name"];
    avator=json["avatar"];
  }
}