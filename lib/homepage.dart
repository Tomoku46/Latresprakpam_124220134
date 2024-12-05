import 'package:flutter/material.dart';
import 'package:latres_124220134/blogpage.dart';
import 'package:latres_124220134/loginpage.dart';
import 'package:latres_124220134/newspage.dart';
import 'package:latres_124220134/reportpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
    });
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Welcome, $username!', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCustomCard(
              context,
              imageUrl: 'https://www.kindpng.com/picc/m/396-3969430_news-icon-icon-news-logo-hd-png-download.png', // Ganti dengan URL gambar
              title: 'Go to News',
              subtitle: 'View the latest space news',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewsPage()));
              },
            ),
            _buildCustomCard(
              context,
              imageUrl: 'https://cdn2.vectorstock.com/i/1000x1000/51/76/blog-icon-vector-7345176.jpg', // Ganti dengan URL gambar
              title: 'Go to Blog',
              subtitle: 'View the latest space blogs',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BlogPage()));
              },
            ),
            _buildCustomCard(
              context,
              imageUrl: 'https://cdn.vectorstock.com/i/1000v/01/62/business-report-icon-vector-26520162.jpg', // Ganti dengan URL gambar
              title: 'Go to Report',
              subtitle: 'View the latest space reports',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ReportPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCard(BuildContext context,
      {required String imageUrl,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Kolom kiri untuk gambar
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16), // Jarak antar kolom
            // Kolom kanan untuk teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris pertama: Judul
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Baris kedua: Deskripsi singkat
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
