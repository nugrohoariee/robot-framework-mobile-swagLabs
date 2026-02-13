---
trigger: always_on
---

# Software Architecture & Folder Structure Guidelines

Dokumen ini mendefinisikan standar arsitektur untuk proyek **Robot Framework Mobile Testing (SwagLabs)**. Tujuannya adalah untuk menjaga keteraturan kode, skalabilitas, dan pemisahan tanggung jawab yang jelas antar lapisan automation testing.

---

## 1. Struktur Folder Utama (Root)

Semua kode test automation berada di dalam root project untuk memisahkan konfigurasi, resource, dan test case secara terstruktur.

```
robot-framework-mobile-swagLabs/
├── apk/                    # File APK yang digunakan untuk testing
├── resources/              # Semua resource pendukung (POM, Data, Utils)
│   ├── POM/                # Page Object Model (Locator & Keyword per halaman)
│   ├── dataFiles/          # Test Data (JSON) untuk data-driven testing
│   └── utils/              # Shared Keywords, Setup, & Utility
├── test/                   # Test Case files
├── results/                # Output: log, report, screenshot
├── config.py               # Konfigurasi path dinamis (Python)
├── requirements.txt        # Dependency Python & Robot Framework
└── .agent/                 # Dokumentasi standarisasi & workflows
```
