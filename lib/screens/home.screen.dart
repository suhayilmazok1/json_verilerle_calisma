import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ornek_proje/models/urunler.model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UrunlerModel? _veriler;

  List<Urunler> _urunler = [];

  void _loadData() async {
    try {
      final dataString = await rootBundle.loadString("asset/files/data.json");
      final dataJson = jsonDecode(dataString);
      _veriler = UrunlerModel.fromJson(dataJson);
      _urunler = _veriler!.urunler!;
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  void _filterData(int id) {
    _urunler = _veriler!.urunler!
        .where((verilerEleman) => verilerEleman.kategori == id)
        .toList();

    setState(() {});
  }

  void _resetFilter() {
    _urunler = _veriler!.urunler!;
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _veriler == null
              ? Text("veriler yükleniyor...")
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: _resetFilter,
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber, // Butonun arka plan rengi
                        foregroundColor: Colors.white, // Yazı rengi
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // İç boşluk
                        elevation: 5, // Gölge yüksekliği
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Köşeleri yuvarlatma
                        ),
                      ),
                        child: Text("Tüm Ürünler")
                        
                      ),
                    ),
                    _kategorilerView(),
                    Expanded(child: _urunlerView()),
                  ],
                ),
        ),
      ),
    );
  }

  ListView _urunlerView() {
  return ListView.separated(
    itemCount: _urunler.length,
    itemBuilder: (context, index) {
      final Urunler urun = _urunler[index]; 
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestPage(
                title: urun.isim!,    
                imageUrl: urun.resim!, 
              ),
            ),
          );
        },
        leading: Image.network(
          urun.resim!,
          width: 100,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(urun.isim!),
      );
    },
    separatorBuilder: (context, index) => const Divider(height: 10),
  );
}

  Row _kategorilerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_veriler!.kategoriler!.length, (index) {
        final kategori = _veriler!.kategoriler![index];
        return GestureDetector(
          onTap: () => _filterData(kategori.id ?? 0),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(kategori.isim ?? "N/A"),
          ),
        );
      }),
    );
  }
}

Future<void> navigateToPush(BuildContext context, Widget page) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

class TestPage extends StatefulWidget {

  final String title;
  final String imageUrl;

  const TestPage({
    super.key, 
    required this.title, 
    required this.imageUrl,

  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Image.network(widget.imageUrl,),
      ));
  }
}
// String fonksiyonlar
// String to num dönüşümleri
// int double fonksiyonları
// liste fonskiyonları
// methodlar , classlar