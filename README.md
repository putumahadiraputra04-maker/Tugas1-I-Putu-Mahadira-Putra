# InventarisKu (Tugas 1 TI253304)

Aplikasi Flutter sederhana: login, menu (Data | Profil), CRUD barang, penyimpanan SharedPreferences.

Akun demo: `admin@inventaris.com` / `123456`

## Menjalankan
Jika folder platform (android/ios/web) belum ada, jalankan sekali di folder ini:

    flutter create . --project-name inventaris_ku
    flutter pub get
    flutter analyze
    flutter run

Arsitektur: View -> ViewModel -> Repository -> SharedPreferences.
