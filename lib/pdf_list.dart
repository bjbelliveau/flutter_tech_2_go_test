import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter_tech_2_go_test/data/tech_tips.dart';
import 'package:recase/recase.dart';
import 'widget_utils.dart' show screenAwareSize;

Future<List<TechTip>> fetchTechTips() async {
  final response =
      await rootBundle.loadString('assets/json/techResources.json');

  return compute(parseTechTips, response);
}

List<TechTip> parseTechTips(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<TechTip>((json) => TechTip.fromJson(json)).toList();
}

class PdfList extends StatefulWidget {
  final String title;

  const PdfList({Key key, this.title}) : super(key: key);

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 52, 136, 1.0),
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) print("Error: ${snapshot.error}");

          return snapshot.hasData
              ? ListViewTechtips(
                  techTips: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
        future: fetchTechTips(),
      )),
    );
  }
}

class ListViewTechtips extends StatelessWidget {
  final List<TechTip> techTips;

  const ListViewTechtips({Key key, this.techTips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    techTips.sort((a, b) =>
        a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));
    return ListView.builder(
      itemCount: techTips.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          leading: Icon(
            Icons.print,
            color: Color.fromRGBO(1, 57, 136, 1.0),
          ),
          title: Text(
            techTips[index].modelName,
            style: TextStyle(fontSize: screenAwareSize(20.0, context)),
          ),
          children: techTips[index]
              .pdfs
              .map<Widget>((pdf) => _getTechTipsPdfs(context, pdf))
              .toList(),
        );
      },
    );
  }

  _getTechTipsPdfs(BuildContext context, String pdf) {
    ReCase rc = ReCase(pdf);
    String pdfTitle = rc.titleCase;
    return ListTile(
      contentPadding: EdgeInsets.only(left: screenAwareSize(35.0, context), right: screenAwareSize(15.0, context)),
      leading: Icon(
        Icons.picture_as_pdf,
        color: Colors.red[900],
      ),
      title: Text(pdfTitle),
      onTap: () => FlutterPdfViewer.loadAsset('assets/pdf/tips/$pdf.pdf'),
    );
  }
}
