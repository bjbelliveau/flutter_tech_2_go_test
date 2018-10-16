class TechTip {
  final String modelName;
  final String group;
  final List<String> pdfs;

  TechTip({this.modelName, this.group, this.pdfs});

  factory TechTip.fromJson(Map<String, dynamic> parsedJson) {
    var pdfFromJson = parsedJson["Pdf"];
    List<String> pdfList = pdfFromJson.cast<String>();

    return TechTip(
      modelName: parsedJson["ModelName"],
      group: parsedJson["PrinterGroup"],
      pdfs: pdfList,
    );
  }
}