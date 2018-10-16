class Product {
  String modelName;
  String itemNumber;
  String crossRef;

  Product.fromJson(Map json) {
    this.modelName = json['ModelName'];
    this.itemNumber = json['ItemNumber'];
    this.crossRef = json['CrossRef'];
  }
}
