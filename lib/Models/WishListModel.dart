class WishListModel{

  late final String ? itemCategory;
  late final String ? itemColor;
  late final String ? itemID;
  late final String ? itemImage;
  late final String ? itemName;
  late final String ? itemNameAR;
  late final double ? itemPrice;
  late final String ? itemSize;


  WishListModel({this.itemCategory,this.itemColor,this.itemID,this.itemImage,this.itemName,this.itemPrice,this.itemSize,this.itemNameAR});

  WishListModel.fromJson(Map<String,dynamic>json){
    itemCategory=json["itemCategory"];
    itemColor=json["itemColor"];
    itemID=json["itemID"];
    itemImage=json["itemImage"];
    itemName=json["itemName"];
    itemNameAR=json["itemNameAR"];
    itemPrice=json["itemPrice"];
    itemSize=json["itemSize"];
  }


}