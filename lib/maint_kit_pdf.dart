import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter_tech_2_go_test/data/tech_tips.dart';

Future<List<TechTip>> fetchTechTips() async {
  final response =
      await rootBundle.loadString('assets/json/maintKitCategory.json');

  return compute(parseTechTips, response);
}

List<TechTip> parseTechTips(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<TechTip>((json) => TechTip.fromJson(json)).toList();
}

class MaintKitPdfList extends StatefulWidget {
  final String title;

  const MaintKitPdfList({Key key, this.title}) : super(key: key);

  @override
  _MaintKitPdfListState createState() => _MaintKitPdfListState();
}

class _MaintKitPdfListState extends State<MaintKitPdfList> {
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
              ? ListViewMaintKit(
                  maintKits: snapshot.data,
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

class ListViewMaintKit extends StatelessWidget {
  final List<TechTip> maintKits;

  const ListViewMaintKit({Key key, this.maintKits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    maintKits.sort((a, b) =>
        a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));
    return ListView.builder(
      itemCount: maintKits.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.print,
            color: Colors.blue,
          ),
          title: Text(
            maintKits[index].modelName,
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(maintKits[index].group),
          onTap: () async {
            print(maintKits[index].pdfs[0]);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Downloading PDF'),
              duration: Duration(days: 24),
            ));

            String filePath = await FlutterPdfViewer.downloadAsFile(
              "https://www.laserpros.com/img/Instructions/${maintKits[index].pdfs[0]}",
            );

            Scaffold.of(context).hideCurrentSnackBar();

            FlutterPdfViewer.loadFilePath(filePath);
          },
        );
      },
    );
  }
}
