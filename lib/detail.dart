// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'data.dart';
// import 'rating_bar.dart';
// import 'favorite_provider.dart';

// class Detail extends StatelessWidget {
//   final Jam jam;

//   Detail(this.jam);

//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(
//       elevation: .5,
//       title: Text('Chusnia Elite Watches'),
//       actions: <Widget>[
//         Consumer<FavoriteProvider>(
//           builder: (context, favoriteProvider, child) {
//             final isFavorite = favoriteProvider.favoriteJams.contains(jam);
//             return IconButton(
//               icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
//               onPressed: () {
//                 if (isFavorite) {
//                   favoriteProvider.removeFavorite(jam);
//                 } else {
//                   favoriteProvider.addFavorite(jam);
//                 }
//               },
//             );
//           },
//         ),
//       ],
//     );

//     return Scaffold(
//       appBar: appBar,
//       body: Column(
//         children: <Widget>[
//           _buildTopContent(context),
//           _buildBottomContent(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTopContent(BuildContext context) {
//     return Container(
//       color: Color(0xFFFE1AFD1),
//       padding: EdgeInsets.only(bottom: 16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(flex: 2, child: _buildTopLeft(context)),
//           Expanded(flex: 3, child: _buildTopRight(context)),
//         ],
//       ),
//     );
//   }

//   Widget _buildTopLeft(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Hero(
//             tag: jam.title,
//             child: Material(
//               elevation: 15.0,
//               shadowColor: Color.fromARGB(255, 245, 242, 247),
//               child: Image(
//                 image: AssetImage(jam.image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTopRight(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         _text(jam.title,
//             size: 16,
//             isBold: true,
//             color: Colors.white70,
//             padding: EdgeInsets.only(top: 16.0)),
//         _text(
//           'oleh ${jam.writer}',
//           color: Colors.white70,
//           size: 12,
//           padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
//         ),
//         Row(
//           children: <Widget>[
//             _text(
//               jam.price,
//               isBold: true,
//               color: Colors.white70,
//               padding: EdgeInsets.only(right: 8.0),
//             ),
//             RatingBar(rating: jam.rating, color: Colors.white70)
//           ],
//         ),
//         SizedBox(height: 32.0),
//         Material(
//           borderRadius: BorderRadius.circular(20.0),
//           shadowColor: Colors.blue.shade200,
//           elevation: 5.0,
//           child: MaterialButton(
//             onPressed: () {
//               _launchURL(
//                   'https://wa.me/6285747579309?text=Halo nia cantik,%20saya%20tertarik%20untuk%20membeli%20produk%20ini');
//             },
//             minWidth: 160.0,
//             color: Color(0xFFFAD88C6),
//             child: _text('BELI', color: Colors.white, size: 13),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildBottomContent() {
//     return Container(
//       height: 220.0,
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Text(
//           jam.description,
//           style: TextStyle(fontSize: 13.0, height: 1.5),
//         ),
//       ),
//     );
//   }

//   Widget _text(String data,
//       {Color color = Colors.black87,
//       num size = 14,
//       EdgeInsetsGeometry padding = EdgeInsets.zero,
//       bool isBold = false}) {
//     return Padding(
//       padding: padding,
//       child: Text(
//         data,
//         style: TextStyle(
//             color: color,
//             fontSize: size.toDouble(),
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
//       ),
//     );
//   }

//   _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data.dart';
import 'rating_bar.dart';
import 'favorite_provider.dart';

class Detail extends StatelessWidget {
  final Jam jam;

  Detail(this.jam);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      title: Text('Chusnia Elite Watches'),
      actions: <Widget>[
        Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            final isFavorite = favoriteProvider.favoriteJams.contains(jam);
            return IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                favoriteProvider.toggleFavorite(jam);
              },
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          _buildTopContent(context),
          _buildBottomContent(),
        ],
      ),
    );
  }

  Widget _buildTopContent(BuildContext context) {
    return Container(
      color: Color(0xFFFE1AFD1),
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 2, child: _buildTopLeft(context)),
          Expanded(flex: 3, child: _buildTopRight(context)),
        ],
      ),
    );
  }

  Widget _buildTopLeft(BuildContext context) {
    return Column(
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
  }

  Widget _buildTopRight(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _text(jam.title,
            size: 16,
            isBold: true,
            color: Colors.white70,
            padding: EdgeInsets.only(top: 16.0)),
        _text(
          'oleh ${jam.writer}',
          color: Colors.white70,
          size: 12,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        Row(
          children: <Widget>[
            _text(
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
              _launchURL(
                  'https://wa.me/6285747579309?text=Halo nia cantik,%20saya%20tertarik%20untuk%20membeli%20produk%20ini');
            },
            minWidth: 160.0,
            color: Color(0xFFFAD88C6),
            child: _text('BELI', color: Colors.white, size: 13),
          ),
        )
      ],
    );
  }

  Widget _buildBottomContent() {
    return Container(
      height: 220.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          jam.description,
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
      ),
    );
  }

  Widget _text(String data,
      {Color color = Colors.black87,
      num size = 14,
      EdgeInsetsGeometry padding = EdgeInsets.zero,
      bool isBold = false}) {
    return Padding(
      padding: padding,
      child: Text(
        data,
        style: TextStyle(
            color: color,
            fontSize: size.toDouble(),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
