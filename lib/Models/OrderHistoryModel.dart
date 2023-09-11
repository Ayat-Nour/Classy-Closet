class OrderHistoryModel{

  late final String ? userID;
  late final String ? orderID;
  late final String ? orderTime;
  late final int ? orderTotalQuantity;
  late final double ? orderTotalPrice;
  late final int ? orderStatus;
  late final List<dynamic> ? orderImages;



  OrderHistoryModel({this.userID,this.orderTotalPrice,this.orderImages,this.orderTotalQuantity,this.orderTime,this.orderStatus,this.orderID});

  OrderHistoryModel.fromJson(Map<String,dynamic>json){
    userID=json["userID"];
    orderID=json["orderID"];
    orderTime=json["orderTime"];
    orderTotalQuantity=json["orderTotalQuantity"];
    orderTotalPrice=json["orderTotalPrice"];
    orderStatus=json["orderStatus"];
    orderImages=json["orderImages"];


  }


}