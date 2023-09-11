class ItemModel{

  late final String ? itemCategory;
  late final List<dynamic> ? itemColor;
  late final String ? itemID;
  late final List<dynamic> ? itemImage;
  late final String ? itemName;
  late final String ? itemNameAR;
  late final String ? itemPrice;
  late final List<dynamic> ? itemSize;
  late final String ? itemRate;


  ItemModel({this.itemCategory,this.itemColor,this.itemID,this.itemImage,this.itemName,this.itemPrice,this.itemSize,this.itemRate,this.itemNameAR});

  ItemModel.fromJson(Map<String,dynamic>json){
    itemCategory=json["itemCategory"];
    itemColor=json["itemColor"];
    itemID=json["itemID"];
    itemImage=json["itemImage"];
    itemName=json["itemName"];
    itemNameAR=json["itemNameAR"];
    itemPrice=json["itemPrice"];
    itemSize=json["itemSize"];
    itemRate=json["itemRate"];
  }


}