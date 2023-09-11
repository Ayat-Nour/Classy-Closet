class UserModel{

  late final String ? id;
  late final String ? name;
  late final String ? email;
  late final String ? password;
  late final String ? phone;
  late final String ? country;
  late final String ? address;
  late final String ? img;

  UserModel({this.name,this.img,this.id,this.country,this.password,this.email,this.phone,this.address});

  UserModel.fromJson(Map<String,dynamic>json){
    id=json["id"];
    name=json["name"];
    email=json["email"];
    password=json["password"];
    phone=json["phone"];
    country=json["country"];
    address=json["address"];
    img=json["img"];
  }


}