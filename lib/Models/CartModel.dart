class CartModel{

  late final String ? userID;
  late final String ? itemID;
  late final String ? itemName;
  late final String ? itemNameAR;
  late final int ? itemQuantity;
  late final String ? itemSize;
  late final String ? itemColor;
  late final String ? itemImage;
  late final double ? itemPrice;


  CartModel({this.itemSize,this.itemColor,this.itemName,this.itemID,this.itemPrice,this.userID,this.itemQuantity,this.itemImage,this.itemNameAR});

  CartModel.fromJson(Map<String,dynamic>json){
    userID=json["userID"];
    itemID=json["itemID"];
    itemName=json["itemName"];
    itemNameAR=json["itemNameAR"];
    itemQuantity=json["itemQuantity"];
    itemSize=json["itemSize"];
    itemColor=json["itemColor"];
    itemImage=json["itemImage"];
    itemPrice=json["itemPrice"];

  }


}