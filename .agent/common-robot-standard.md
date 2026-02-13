# 📘 Standarisasi `common.robot`

## 1. Peran & Fungsi

`common.robot` adalah **file utility utama** yang menjadi pusat dari:
- **Konfigurasi Appium** (variabel koneksi device)
- **Load test data** dari JSON
- **Setup & teardown** untuk setiap test case
- **Shared keywords** yang dipakai lintas test case

> **Lokasi**: `resources/utils/common.robot`

---

## 2. Struktur Standar

File `common.robot` harus mengikuti urutan section berikut:

```robot
*** Settings ***
# 1. Library imports
# 2. Variables import (config.py)
# 3. Resource imports (POM files yang dibutuhkan)

*** Variables ***
# 1. Appium connection variables
# 2. Path variables (menggunakan BASE_PATH dari config.py)
# 3. Runtime/state variables (diinisialisasi ${None})

*** Keywords ***
# 1. Data loading keywords
# 2. Setup keywords
# 3. Shared/utility keywords
```

---

## 3. Section: `*** Settings ***`

### Standar Saat Ini
```robot
*** Settings ***
Library      AppiumLibrary
Library      JSONLibrary
Variables    ../../config.py
Resource     ../POM/loginPage.robot
```

### Aturan
| Item | Aturan |
|------|--------|
| **Library** | Import semua library yang dibutuhkan secara global |
| **Variables** | Selalu import `config.py` untuk mendapatkan `BASE_PATH` |
| **Resource** | Import **hanya** POM file yang keyword-nya dipanggil langsung dari `common.robot` |

> **Catatan**: `loginPage.robot` di-import karena keyword `Isi Form Login` dan `Klik Tombol Login` dipanggil langsung di keyword `Setup Login App`.

---

## 4. Section: `*** Variables ***`

### Kategori Variabel

#### A. Appium Connection (WAJIB)
```robot
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM}       Android
${DEVICE_NAME}    emulator-5554
${PACKAGE}        com.swaglabsmobileapp
${ACTIVITY}       com.swaglabsmobileapp.SplashActivity
```

#### B. Path Variables (Menggunakan `BASE_PATH`)
```robot
${APP_PATH}       ${BASE_PATH}/apk/saucelabs.apk
${JSON_PATH}      ${BASE_PATH}/resources/dataFiles/users.json
${JSON_COINFO}    ${BASE_PATH}/resources/dataFiles/COInfo.json
```

> `BASE_PATH` berasal dari `config.py` — otomatis resolve ke root project.

#### C. Runtime/State Variables
```robot
${JSON_DATA}      ${None}
${LOGIN_DATA}     ${None}
${CO_DATA}        ${None}
${USER_TYPE}      ${None}
```

### Aturan Penamaan Variabel

| Kategori | Prefix/Format | Contoh |
|----------|---------------|--------|
| URL/Connection | Deskriptif | `${REMOTE_URL}`, `${PLATFORM}` |
| Path | `*_PATH` | `${APP_PATH}`, `${JSON_PATH}` |
| Data JSON | `*_DATA` | `${LOGIN_DATA}`, `${CO_DATA}` |
| State | Sesuai konteks | `${USER_TYPE}` |

---

## 5. Section: `*** Keywords ***`

### Keyword 1: `Load All Test Data`

**Fungsi**: Memuat semua file JSON test data sekali saja di level Suite.

```robot
Load All Test Data
    ${data_login}=    Load Json From File    ${JSON_PATH}
    ${data_co}=       Load Json From File    ${JSON_COINFO}

    Set Suite Variable
    ...    ${LOGIN_DATA}
    ...    ${data_login}

    Set Suite Variable
    ...    ${CO_DATA}
    ...    ${data_co}
```

**Aturan**:
- Dipanggil **hanya** sebagai `Suite Setup`, bukan di setiap test case
- Gunakan `Set Suite Variable` agar data berlaku untuk seluruh suite
- Jika ada JSON baru, tambahkan load & set di keyword ini

---

### Keyword 2: `Setup Login App`

**Fungsi**: Membuka aplikasi via Appium + login otomatis berdasarkan tipe user.

```robot
Setup Login App
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=UiAutomator2
    ...    app=${APP_PATH}
    ...    appPackage=${PACKAGE}
    ...    appActivity=${ACTIVITY}
    ...    noReset=false
    Capture Page Screenshot

    [Arguments]    ${user_type}
    Wait Until Element Is Visible
    ...    accessibility_id=test-Username
    ...    timeout=15s

    Isi Form Login
    ...    ${LOGIN_DATA['${user_type}']['user_name']}
    ...    ${LOGIN_DATA['${user_type}']['password']}

    Klik Tombol Login
```

**Aturan**:
- Dipanggil sebagai `[Setup]` di setiap test case
- Parameter `${user_type}` harus cocok dengan key di `users.json`
- `noReset=false` memastikan app selalu fresh

---

## 6. Best Practices

### ✅ DO (Lakukan)
- Selalu definisikan variabel Appium di `common.robot`, bukan di test case
- Load data JSON **sekali** di `Suite Setup`
- Gunakan `Set Suite Variable` untuk data yang dipakai lintas test
- Gunakan `${BASE_PATH}` untuk semua path file — jangan hardcode
- `[Arguments]` harus didefinisikan **sebelum** body keyword (perbaikan yang perlu dilakukan)

### ❌ DON'T (Hindari)
- Jangan load JSON di setiap test case
- Jangan hardcode path (contoh: `E:/KERJA RIO/RND/...`)
- Jangan definisikan locator di `common.robot` — locator hanya di POM files
- Jangan import POM file yang tidak dipakai langsung di `common.robot`

---

## 7. Template untuk Menambah Data Baru

Jika perlu menambah JSON data baru:

### Step 1: Buat file JSON di `resources/dataFiles/`
```json
{
    "scenarioName": {
        "field_1": "value_1"
    }
}
```

### Step 2: Tambahkan variabel di `common.robot`
```robot
*** Variables ***
${JSON_NEW_PATH}    ${BASE_PATH}/resources/dataFiles/newData.json
${NEW_DATA}         ${None}
```

### Step 3: Update keyword `Load All Test Data`
```robot
Load All Test Data
    # ... existing loads ...
    ${data_new}=    Load Json From File    ${JSON_NEW_PATH}
    Set Suite Variable    ${NEW_DATA}    ${data_new}
```

---

## 8. Catatan Perbaikan

> [!WARNING]
> Pada `Setup Login App`, `[Arguments]` saat ini berada **setelah** `Open Application`.
> Menurut standar Robot Framework, `[Arguments]` harus berada di **baris pertama** setelah nama keyword.
> Ini perlu diperbaiki agar sesuai best practice.

```diff
 Setup Login App
+    [Arguments]    ${user_type}
     Open Application    ${REMOTE_URL}
     ...
     Capture Page Screenshot
-    [Arguments]    ${user_type}
     Wait Until Element Is Visible
     ...
```
