import 'package:flutter/material.dart';
import 'data.dart';
import 'detail.dart';
import 'splash_page.dart';
import 'profile_page.dart';


class Home extends StatelessWidget {
  // Create a global key for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text('Chusnia Elite Watches'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashPage()),
            );
          },
        ),
      ],
    );

    // Function untuk menavigasi ke halaman detail saat gambar diklik
    void navigateToDetail(Jam jam) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Detail(jam)),
      );
    }

    createTile(Jam jam) => Hero(
          tag: jam.title,
          child: Material(
            elevation: 15.0,
            shadowColor:Color(0xFFFAD88C6),
            child: InkWell(
              onTap: () {
                navigateToDetail(jam); // Panggil fungsi navigasi
              },
              child: Image(
                image: AssetImage(jam.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: jams.map((jam) => createTile(jam)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      key: _scaffoldKey, // Assign the key to Scaffold
      backgroundColor: Color(0xFFFFE6E6),
      appBar: appBar,
      body: grid,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 246, 211, 252),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
