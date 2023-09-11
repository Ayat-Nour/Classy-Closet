class CategoriesModel{

  late final String ? categorieID;
  late final String ? categorieImg;
  late final String ? categorieName;


  CategoriesModel({this.categorieImg,this.categorieID,this.categorieName,});

  CategoriesModel.fromJson(Map<String,dynamic>json){
    categorieID=json["categorieID"];
    categorieImg=json["categorieImg"];
    categorieName=json["categorieName"];

  }


}