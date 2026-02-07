# Analisis Project: Robot Framework Mobile SwagLabs

## Ringkasan Project

Project ini adalah **Framework Automation Testing Mobile** untuk aplikasi **SauceLabs SwagLabs** menggunakan **Robot Framework** dengan **Appium**.

---

## Struktur Project

```
robot-framework-mobile-swagLabs/
├── apk/                          # APK aplikasi yang diuji
├── config.py                     # Konfigurasi path dinamis per device
├── requirements.txt              # Dependencies project
├── resources/
│   ├── POM/                      # File Page Object Model
│   │   ├── loginPage.robot
│   │   ├── cartPage.robot
│   │   ├── checkOutPage.robot
│   │   ├── listProductPage.robot
│   │   └── sideBar.robot
│   ├── dataFiles/                # Data test dalam format JSON
│   │   ├── users.json
│   │   └── COInfo.json
│   └── utils/
│       └── common.robot          # Keywords dan setup bersama
├── test/                         # Test cases
│   ├── TC01-Authentication.robot
│   └── TC02-AddToCart.robot
```

---

## Best Practices yang Sudah Diimplementasi

### 1. **Page Object Model (POM) Pattern** 
- Setiap halaman memiliki file `.robot` terpisah
- **Locators** dan **Keywords** dipisahkan per halaman
- Mudah di-maintain dan scalable

### 2. **Data-Driven Testing** 
- Data test disimpan dalam file JSON (`users.json`, `COInfo.json`)
- Pemisahan data dari logic test
- Data dimuat sekali di `Suite Setup` untuk efisiensi

### 3. **Konfigurasi Lintas Perangkat** 
- `config.py` menggunakan `socket.gethostname()` untuk deteksi device
- Path dinamis sesuai environment (Windows/Mac/Linux)
- Tidak perlu hardcode path di setiap file

### 4. **Setup & Utilitas Terpusat** 
- `common.robot` sebagai pusat untuk:
  - Konfigurasi Appium
  - Pemuatan data (`Load All Test Data`)
  - Keywords bersama (`Setup Login App`)

### 5. **Struktur Test yang Bersih** 
- Setup/Teardown yang proper di setiap test case
- Naming convention yang jelas (TC01001, TC01002, dst)
- Suite Setup untuk load data sekali

### 6. **Keywords yang Dapat Digunakan Ulang** 
- Keywords menggunakan bahasa Indonesia yang mudah dibaca
- Contoh: `Isi Form Login`, `Klik Tombol Login`, `Klik Checkout`

### 7. **Screenshot Otomatis** 
- `Capture Page Screenshot` di setiap langkah penting
- Memudahkan debugging dan dokumentasi

### 8. **Manajemen Dependency** 
- `requirements.txt` lengkap dengan version pinning
- Termasuk Robot Framework + Appium Library

---

## Cakupan Test

| Modul | Test Cases |
|-------|------------|
| **Autentikasi** | Login valid, Login invalid, Logout |
| **Keranjang Belanja** | Lihat produk, Tambah ke keranjang, Alur checkout |

---

## Tech Stack

- **Robot Framework** 7.4.1
- **Appium Python Client** 5.2.5
- **JSONLibrary** untuk penanganan data
- **UiAutomator2** untuk automasi Android

---
