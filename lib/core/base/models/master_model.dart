abstract class MasterModel {
  MasterModel();

  static  MasterModel fromJson(Map<String,dynamic> json) ;

  Map<String, dynamic> toJson();

}