import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_2_go_test/data/product_model.dart';
import 'package:flutter_tech_2_go_test/product_details.dart';

import 'widget_utils.dart' show screenAwareSize;

class ProductList extends StatefulWidget {
  final String title;

  const ProductList({Key key, this.title}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isKit = false;

  @override
  Widget build(BuildContext context) {
    isKit = widget.title.toLowerCase() == "maint kits";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Icon(
            Icons.search,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: fetchProducts(getJsonFile(widget.title)),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ProductsList(
                      products: snapshot.data,
                      isKit: isKit,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future<List<Product>> fetchProducts(String jsonFile) async {
    final response = await DefaultAssetBundle.of(context).loadString(jsonFile);

    return compute(parseProducts, response);
  }

  static String getJsonFile(String title) {
    return title.toLowerCase() == 'fusers'
        ? 'assets/json/fuserList.json'
        : 'assets/json/kitList.json';
  }
}

List<Product> parseProducts(String message) {
  final parsed = json.decode(message).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class ProductsList extends StatelessWidget {
  final List<Product> products;
  final isKit;

  const ProductsList({Key key, this.products, this.isKit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    products.sort((a, b) =>
        a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));
    return ListView.builder(
      itemBuilder: (context, index) => fetchListTile(context, index),
      itemCount: products.length,
    );
  }

  Widget fetchListTile(BuildContext context, int index) {
    return Material(
      elevation: 2.0,
      type: MaterialType.card,
      child: Ink.image(
        fit: BoxFit.contain,
        height: screenAwareSize(250.0, context),
        image: AssetImage(
            'assets/images/${products[index].itemNumber.replaceAll('-', '_').toLowerCase()}.jpg'),
        child: InkWell(
          splashColor: Colors.blueAccent.withOpacity(0.3),
          highlightColor: Colors.blue.withOpacity(0.2),
          onTap: () {
            print(products[index].crossRef);
            Navigator.push(
                context,
                ScaleRoute(
                    widget: ProductDetails(
                  product: products[index],
                  isKit: isKit,
                )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenAwareSize(7.0, context),
                      horizontal: screenAwareSize(5.0, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        products[index].modelName,
                        maxLines: 1,
                        minFontSize: 18.0,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenAwareSize(18.0, context),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        products[index].itemNumber,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenAwareSize(13.0, context)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget testListTile(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/images/${products[index].itemNumber.replaceAll('-', '_').toLowerCase()}.jpg',
            fit: BoxFit.cover,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(products[index].modelName),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget transitionImage(String image) {
    return FadeInImage(placeholder: null, image: AssetImage(image));
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget widget;

  ScaleRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.00,
                  0.50,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 1.5,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.25,
                    1.00,
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              child: child,
            ),
          );
        });
}
