
class Mobiledetails{
  String? bname;
  String? oname;
  String? bimage;
  String? mobile;
  List<Mobiledetails>? catmap;
  String? bannerimage;
  Mobiledetails({
    this.bname,
    this.oname,
    this.catmap,
    this.mobile,
    this.bimage,
    this.bannerimage,
    });
  factory Mobiledetails.fromJson(Map<String,dynamic>json){
    return Mobiledetails(
      bname: json['bname'],
      oname: json['oname'],
      mobile: json['mobile'],
      bimage: json['bimage'],
      bannerimage: json['bannerimage'],
    );
  }
}
class MandiBhav{
  String? name;
  String? high;
  String? image;
  String? low;
  String? model;
  List<Mobiledetails>? price;
  MandiBhav({
    this.name,
    this.high,
    this.image,
    this.low,
    this.model,
  });
  factory MandiBhav.fromJson(Map<String,dynamic>json){
    return MandiBhav(
      name: json['name'],
      high: json['max'],
      low: json['min'],
      model: json['model'],
      image: json['image'],
    );
  }
}

class Banners{
  String? banners;
  Banners({
   this.banners,
   });
  factory Banners.fromJson(Map<String,dynamic>json){
    return Banners(
      banners: json['bbimage'],
    );
  }
}

