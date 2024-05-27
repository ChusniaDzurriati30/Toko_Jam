import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'data.dart';
import 'detail.dart';
import 'profile_page.dart';
import 'splash_page.dart';

class Home extends StatelessWidget {
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
      title: Text('Elite Watches'),
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

    void navigateToDetail(Jam jam) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Detail(jam)),
      );
    }

    Widget createTile(Jam jam) => GestureDetector(
          onTap: () {
            navigateToDetail(jam);
          },
          child: Card(
            elevation: 5.0,
            shadowColor: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: jam.title,
                    child: Image.asset(
                      jam.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    jam.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    jam.price,
                    style: TextStyle(fontSize: 14, color: Colors.orange),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${jam.sold} terjual',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );

    final grid = GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: jams.length,
      itemBuilder: (BuildContext context, int index) {
        return createTile(jams[index]);
      },
    );

    List<Map<String, String>> images = [
      {'image': 'assets/images/1.jpeg', 'price': '\$99.99'},
      {'image': 'assets/images/2.jpeg', 'price': '\$149.99'},
      {'image': 'assets/images/3.jpeg', 'price': '\$199.99'},
      {'image': 'assets/images/4.jpeg', 'price': '\$249.99'},
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFE6E6),
      appBar: appBar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Collection',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Discount 50% for the first transaction',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFE1AFD1),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      textStyle: TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Shop Now'),
                  ),
                  SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        // Do something when the page changes
                      },
                    ),
                    items: images.map((item) => Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(item['image']!, fit: BoxFit.cover, width: 1000),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  '${item['price']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: grid),
        ],
      ),
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
