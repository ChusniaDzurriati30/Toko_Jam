class Jam {
  String title,
      writer,
      price,
      image,
      description =
    'Selamat datang di koleksi jam tangan premium kami. Temukan berbagai macam jam tangan dari merek-merek ternama dunia. Setiap jam tangan kami dirancang dengan keahlian terbaik dan bahan berkualitas tinggi untuk memberikan ketepatan waktu yang sempurna dan gaya yang elegan. \n\nApakah Anda mencari jam tangan klasik untuk acara formal atau jam tangan sporty untuk aktivitas sehari-hari, kami memiliki pilihan yang sesuai untuk Anda. Setiap model dilengkapi dengan fitur-fitur inovatif yang memadukan fungsi dan desain. \n\nNikmati pengalaman berbelanja yang menyenangkan dengan layanan pelanggan terbaik dan jaminan kepuasan dari kami. Pilih jam tangan yang mencerminkan kepribadian Anda dan tingkatkan penampilan Anda dengan koleksi kami. \n\nKunjungi toko kami dan temukan jam tangan impian Anda. Terima kasih telah mempercayakan kebutuhan jam tangan Anda kepada kami.';
  double rating;

  Jam(
      this.title, this.writer, this.price, this.image, this.rating );
}

final List<Jam> jams = [
  Jam('Rolex Submariner', 'Rolex', 'Rp 120.000.000', 'assets/images/1.jpeg', 4.8),
  Jam('Omega Speedmaster', 'Omega', 'Rp 75.000.000', 'assets/images/2.jpeg', 4.7),
  Jam('Tag Heuer Carrera', 'Tag Heuer', 'Rp 65.000.000', 'assets/images/3.jpeg', 4.5),
  Jam('Seiko Prospex', 'Seiko', 'Rp 20.000.000', 'assets/images/4.jpeg', 4.3),
  Jam('Casio G-Shock', 'Casio', 'Rp 2.500.000', 'assets/images/5.jpeg', 4.9),
  Jam('Citizen Eco-Drive', 'Citizen', 'Rp 5.000.000', 'assets/images/6.jpeg', 4.6),
  Jam('Tissot Le Locle', 'Tissot', 'Rp 10.000.000', 'assets/images/7.jpeg', 4.7),
  Jam('Hamilton Khaki Field', 'Hamilton', 'Rp 8.000.000', 'assets/images/8.jpeg', 4.5),
  Jam('Breitling Navitimer', 'Breitling', 'Rp 90.000.000', 'assets/images/9.jpeg', 4.8),
  Jam('Tissot Le Locle', 'Dior', 'Rp 10.000.000', 'assets/images/10.jpeg', 4.7),
  Jam('Hamilton Khaki Field', 'Hamilton', 'Rp 8.000.000', 'assets/images/11.jpeg', 4.5),
  Jam('Breitling Navitimer', 'Casio', 'Rp 90.000.000', 'assets/images/12.jpeg', 4.8),
];
