import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tech_2_go_test/data/product_model.dart';

import 'widget_utils.dart' show screenAwareSize;

class ProductDetails extends StatefulWidget {
  final Product product;
  final bool isKit;

  const ProductDetails({Key key, this.product, this.isKit}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    String image =
        'assets/images/${widget.product.itemNumber.replaceAll('-', '_').toLowerCase()}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
        actions: <Widget>[],
        title: Text(
          widget.product.itemNumber,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 2,
              child: widget.isKit
                  ? Image.asset(
                      '$image.jpg',
                      fit: BoxFit.fitWidth,
                    )
                  : _getCarousel(image),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenAwareSize(18.0, context),
                  left: screenAwareSize(8.0, context)),
              child: Text(
                widget.product.modelName,
                style: TextStyle(
                    fontSize: screenAwareSize(22.0, context),
                    fontWeight: FontWeight.w500),
              ),
            ),
            getCrossRef(),
            Padding(
              padding: EdgeInsets.all(screenAwareSize(25.0, context)),
              child: RaisedButton(
                padding: EdgeInsets.all(screenAwareSize(15.0, context)),
                onPressed: () {},
                color: Colors.blue[900],
                elevation: 2.0,
                child: AutoSizeText(
                  "Find ${widget.product.itemNumber} on the web",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenAwareSize(20.0, context),
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getCarousel(String image) {
    var images = [
      image + '.jpg',
      image + '_2.jpg',
      image + '_3.jpg',
      image + '_4.jpg'
    ];

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          images[index],
          fit: BoxFit.fitWidth,
        );
      },
      itemCount: images.length,
      control: SwiperControl(
        color: Colors.blue[900],

      ),
    );
  }

  getCrossRef() {
    if (widget.product.crossRef.isEmpty || widget.product.crossRef == '') {
      return Container();
    } else {
      return Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenAwareSize(15.0, context),
              vertical: screenAwareSize(25.0, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Cross Reference:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(18.0, context),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.product.crossRef,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenAwareSize(14.0, context),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
