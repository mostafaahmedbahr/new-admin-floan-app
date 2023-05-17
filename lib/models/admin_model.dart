
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

  AdminModel({
      this.adminName,
      this.adminEmail,
      this.adminId,
      this.adminPhone,
    this.long,
    this.lat,
    this.shopName,
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
  }

    Map<String,dynamic> toMap()
    {
      return {
        "id" : adminId,
        "isAdmin" : isAdmin,
        "phone" :adminPhone ,
         "email" : adminEmail,
        "name" : adminName,
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