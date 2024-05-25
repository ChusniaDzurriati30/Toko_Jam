import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'data.dart';
import 'rating_bar.dart';

class Detail extends StatelessWidget {
  final Jam jam;

  Detail(this.jam);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      title: Text('Chusnia Clock'),
      actions: <Widget>[],
    );

    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: jam.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Color.fromARGB(255, 245, 242, 247),
              child: Image(
                image: AssetImage(jam.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );

    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(jam.title,
            size: 16,
            isBold: true,
            color: Colors.white70,
            padding: EdgeInsets.only(top: 16.0)),
        text(
          'oleh ${jam.writer}',
          color: Colors.white70,
          size: 12,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        Row(
          children: <Widget>[
            text(
              jam.price,
              isBold: true,
              color: Colors.white70,
              padding: EdgeInsets.only(right: 8.0),
            ),
            RatingBar(rating: jam.rating, color: Colors.white70)
          ],
        ),
        SizedBox(height: 32.0),
        Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {
               _launchURL('https://wa.me/6285747579309?text=Halo nia cantik,%20saya%20tertarik%20untuk%20membeli%20produk%20ini'); // WhatsApp URL with specific number and message
            },
            minWidth: 160.0,
            color: Color(0xFFFAD88C6),
            child: text('BELI', color: Colors.white, size: 13),
          ),
        )
      ],
    );

    final topContent = Container(
      color: Color(0xFFFE1AFD1),
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    final bottomContent = Container(
      height: 220.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          jam.description,
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  text(String data,
          {Color color = Colors.black87,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
