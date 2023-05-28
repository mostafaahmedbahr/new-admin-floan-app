
class AdminModel
{
    String? adminName;
    String? adminId;
    bool? isAdmin;
    String? adminEmail;
  String? adminPhone;
  double? lat;
  double? long;
  String? shopName;
  String? shopImage;

  AdminModel({
      this.adminName,
      this.adminEmail,
      this.adminId,
      this.adminPhone,
    this.long,
    this.lat,
    this.shopName,
    this.shopImage,
    this.isAdmin,

  });

  AdminModel.fromJson(Map<String,dynamic>? json)
  {
    adminId = json!["id"];
    adminPhone = json["phone"];
    adminEmail = json["email"];
    adminName = json["name"];
    shopName = json["shopName"];
    lat = json["lat"];
    isAdmin = json["isAdmin"];
    long = json["long"];
    shopImage = json["shopImage"];
  }

    Map<String,dynamic> toMap()
    {
      return {
        "id" : adminId,
        "isAdmin" : isAdmin,
        "phone" :adminPhone ,
         "email" : adminEmail,
        "name" : adminName,
        "shopImage" : shopImage,
        "long" :long ,
        "lat" : lat,
        "shopName" :shopName ,
      };
    }

  // factory AdminModel.fromDocument(DocumentSnapshot doc)
  // {
  //   return AdminModel(
  //     adminName: doc["name"],
  //     adminId: doc["id"],
  //     adminEmail:  doc["email"],
  //     adminPhone: doc["phone"],
  //
  //   );
  // }





}