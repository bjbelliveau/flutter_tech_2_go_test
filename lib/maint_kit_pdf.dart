import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_tech_2_go_test/data/tech_tips.dart';
import 'package:recase/recase.dart';

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
            color: Colors.blue,
          ),
          title: Text(
            techTips[index].modelName,
            style: TextStyle(fontSize: 20.0),
          ),
          children: techTips[index]
              .pdfs
              .map<Widget>((pdf) => _getTechTipsPdfs(pdf))
              .toList(),
        );
      },
    );
  }

  _getTechTipsPdfs(String pdf) {
//    String pdfTitle = pdf.toUpperCase().replaceAll("-", " ");
    ReCase rc = ReCase(pdf);
    String pdfTitle = rc.titleCase;
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35.0, right: 15.0),
      leading: Icon(
        Icons.picture_as_pdf,
        color: Colors.red[900],
      ),
      title: Text(pdfTitle),
      onTap: () => print(pdf),
    );
  }
}
