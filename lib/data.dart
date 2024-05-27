class Jam {
  String title,
      writer,
      price,
      image,
      description =
    'Selamat datang di koleksi jam tangan premium kami. Temukan berbagai macam jam tangan dari merek-merek ternama dunia. Setiap jam tangan kami dirancang dengan keahlian terbaik dan bahan berkualitas tinggi untuk memberikan ketepatan waktu yang sempurna dan gaya yang elegan. \n\nApakah Anda mencari jam tangan klasik untuk acara formal atau jam tangan sporty untuk aktivitas sehari-hari, kami memiliki pilihan yang sesuai untuk Anda. Setiap model dilengkapi dengan fitur-fitur inovatif yang memadukan fungsi dan desain. \n\nNikmati pengalaman berbelanja yang menyenangkan dengan layanan pelanggan terbaik dan jaminan kepuasan dari kami. Pilih jam tangan yang mencerminkan kepribadian Anda dan tingkatkan penampilan Anda dengan koleksi kami. \n\nKunjungi toko kami dan temukan jam tangan impian Anda. Terima kasih telah mempercayakan kebutuhan jam tangan Anda kepada kami.';
  double rating;
  int _sold;

  Jam(this.title, this.writer, this.price, this.image, this.rating, this._sold);

  int get sold => _sold;

  void setSold(int newSold) {
    _sold = newSold;
  }
}

final List<Jam> jams = [
  Jam('Rolex Submariner', 'Rolex', '\$8,276.00', 'assets/images/1.jpeg', 4.8, 5400),
  Jam('Omega Speedmaster', 'Omega', '\$5,172.41', 'assets/images/2.jpeg', 4.7, 10000),
  Jam('Tag Heuer Carrera', 'Tag Heuer', '\$4,482.76', 'assets/images/3.jpeg', 4.5, 3100),
  Jam('Seiko Prospex', 'Seiko', '\$1,379.31', 'assets/images/4.jpeg', 4.3, 754),
  Jam('Casio G-Shock', 'Casio', '\$172.41', 'assets/images/5.jpeg', 4.9, 5400),
  Jam('Citizen Eco-Drive', 'Citizen', '\$344.83', 'assets/images/6.jpeg', 4.6, 10000),
  Jam('Tissot Le Locle', 'Tissot', '\$689.66', 'assets/images/7.jpeg', 4.7, 3100),
  Jam('Hamilton Khaki Field', 'Hamilton', '\$551.72', 'assets/images/8.jpeg', 4.5, 754),
  Jam('Breitling Navitimer', 'Breitling', '\$6,206.90', 'assets/images/9.jpeg', 4.8, 5400),
  Jam('Tissot Le Locle', 'Dior', '\$689.66', 'assets/images/10.jpeg', 4.7, 10000),
  Jam('Hamilton Khaki Field', 'Hamilton', '\$551.72', 'assets/images/11.jpeg', 4.5, 3100),
  Jam('Breitling Navitimer', 'Casio', '\$6,206.90', 'assets/images/12.jpeg', 4.8, 754),
];
