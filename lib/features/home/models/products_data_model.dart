import 'package:in_the_kloud_app/features/home/models/product_model.dart';

class ProductsDataModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsDataModel({this.products, this.total, this.skip, this.limit});

  ProductsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}
