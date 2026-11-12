class Barang {
  final String id;
  final String nama;
  final String kategori;
  final int jumlah;
  final String tanggal; // format yyyy-MM-dd

  const Barang({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.jumlah,
    required this.tanggal,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        id: json['id'] as String,
        nama: json['nama'] as String,
        kategori: json['kategori'] as String,
        jumlah: json['jumlah'] as int,
        tanggal: json['tanggal'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'kategori': kategori,
        'jumlah': jumlah,
        'tanggal': tanggal,
      };
}
