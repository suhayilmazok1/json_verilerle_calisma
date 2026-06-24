// ignore_for_file: unnecessary_this

class UrunlerModel {
  List<Urunler>? urunler;
  List<Kategoriler>? kategoriler;

  UrunlerModel({this.urunler, this.kategoriler});

  UrunlerModel.fromJson(Map<String, dynamic> json) {
    if (json['urunler'] != null) {
      urunler = <Urunler>[];
      json['urunler'].forEach((v) {
        urunler!.add(Urunler.fromJson(v));
      });
    }
    if (json['kategoriler'] != null) {
      kategoriler = <Kategoriler>[];
      json['kategoriler'].forEach((v) {
        kategoriler!.add(Kategoriler.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.urunler != null) {
      data['urunler'] = this.urunler!.map((v) => v.toJson()).toList();
    }
    if (this.kategoriler != null) {
      data['kategoriler'] = this.kategoriler!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urunler {
  int? id;
  int? kategori;
  String? isim;
  String? resim;

  Urunler({this.id, this.kategori, this.isim, this.resim});

  Urunler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategori = json['kategori'];
    isim = json['isim'];
    resim = json['resim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori'] = this.kategori;
    data['isim'] = this.isim;
    data['resim'] = this.resim;
    return data;
  }
}

class Kategoriler {
  int? id;
  String? isim;

  Kategoriler({this.id, this.isim});

  Kategoriler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isim = json['isim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['isim'] = this.isim;
    return data;
  }
}
