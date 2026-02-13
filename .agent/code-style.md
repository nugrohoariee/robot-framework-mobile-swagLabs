---
trigger: always_on
---

# Code Style Guidelines — Clean Code, DRY, POM & DDT

Dokumen ini mendefinisikan aturan penulisan kode untuk proyek Robot Framework Mobile Testing agar tetap **bersih, tidak redundan, dan mudah di-maintain**.

---

## 1. Clean Code

### Naming Convention

| Jenis | Format | Contoh ✅ | Hindari ❌ |
|-------|--------|-----------|-----------|
| File Test Case | `TC{XX}-{NamaFitur}.robot` | `TC01-Authentication.robot` | `test1.robot` |
| File POM | `{namaHalaman}Page.robot` | `loginPage.robot` | `login.robot` |
| Variabel Button | `${BTN_NAMA}` | `${BTN_LOGIN}` | `${TOMBOL}` |
| Variabel Field | `${FIELD_NAMA}` | `${FIELD_USERNAME}` | `${INPUT1}` |
| Variabel Error | `${ERROR_NAMA}` | `${ERROR_MESSAGE}` | `${ERR}` |
| Variabel Path | `${NAMA_PATH}` | `${APP_PATH}` | `${PATH1}` |
| Variabel Data | `${NAMA_DATA}` | `${LOGIN_DATA}` | `${DATA}` |
| Keyword | Kata Kerja + Objek (Bahasa Indonesia) | `Isi Form Login` | `Login` |
| ID Test Case | `TC{XX}{YYY}` | `TC01001` | `Test 1` |

### Aturan Penulisan Keyword

```robot
# ✅ BENAR — satu keyword, satu tanggung jawab
Klik Tombol Login
    Click Element    ${BTN_LOGIN}
    Capture Page Screenshot

# ❌ SALAH — keyword melakukan terlalu banyak hal
Login Dan Verifikasi Dan Screenshot Dan Close
    Click Element    ${BTN_LOGIN}
    Wait Until Element Is Visible    ${SUCCESS}
    Capture Page Screenshot
    Close Application
```

### Aturan Umum
- Setiap keyword hanya punya **satu tanggung jawab** (Single Responsibility)
- Nama keyword harus **self-documenting** — tidak perlu komentar tambahan
- Gunakan **4 spasi** sebagai indentasi standar di Robot Framework
- Gunakan **separator minimal 4 spasi** antar kolom
- `[Arguments]` selalu di **baris pertama** setelah nama keyword
- Hapus `Sleep` jika bisa diganti `Wait Until Element Is Visible`

---

## 2. DRY (Don't Repeat Yourself)

### Prinsip: Satu Sumber Kebenaran

| Apa | Tempat Definisi | Jangan Definisikan Ulang di |
|-----|-----------------|----------------------------|
| Locator elemen | POM file (`resources/POM/`) | Test case, common.robot |
| Variabel Appium | `common.robot` | Test case, POM file |
| `BASE_PATH` | `config.py` | Dimanapun (hardcode) |
| Test data | `dataFiles/*.json` | Inline di test case |
| Setup & teardown | `common.robot` (keyword) | Duplikasi di test case |

### Contoh DRY

```robot
# ✅ BENAR — data dari JSON, keyword dari POM
TC02001 - User dapat melakukan add to cart
    [Setup]    Setup Login App    validLogin
    Klik Product
    Klik Cart
    Isi Form CO Info
    ...    ${CO_DATA['COInfo']['first_name']}
    ...    ${CO_DATA['COInfo']['last_name']}
    ...    ${CO_DATA['COInfo']['zip_code']}
    [Teardown]    Close Application

# ❌ SALAH — hardcode data, duplikasi locator
TC02001 - User dapat melakukan add to cart
    [Setup]    Setup Login App    validLogin
    Click Element    xpath=(//android.widget.TextView[@text="ADD TO CART"])[1]
    Input Text    //android.widget.EditText[@content-desc="test-First Name"]    bambang
    [Teardown]    Close Application
```

### Aturan Load Data
- Load JSON **sekali** di `Suite Setup` via `Load All Test Data`
- Gunakan `Set Suite Variable` agar data tersedia di seluruh suite
- **Jangan** load JSON di setiap test case

```robot
# ✅ Di Suite Setup — sekali untuk seluruh suite
Suite Setup    Load All Test Data

# ❌ Jangan load di setiap test case
TC01001
    ${data}=    Load Json From File    ${JSON_PATH}    # JANGAN!
```

---

## 3. POM (Page Object Model)

### Aturan Struktur POM File

Setiap halaman aplikasi = **1 file `.robot`** di `resources/POM/`:

```robot
*** Settings ***
Library    AppiumLibrary
# Import common.robot HANYA jika perlu variabel global

*** Variables ***
# HANYA locator halaman ini — gunakan prefix standar
${BTN_ACTION}       accessibility_id=test-ACTION
${FIELD_INPUT}      //android.widget.EditText[@content-desc="test-Input"]
${ERROR_MSG}        //android.view.ViewGroup[@content-desc="test-Error"]

*** Keywords ***
# HANYA keyword interaksi halaman ini
Klik Action
    Click Element    ${BTN_ACTION}

Isi Form Input
    [Arguments]    ${value}
    Input Text     ${FIELD_INPUT}    ${value}
```

### Aturan POM

| Aturan | Penjelasan |
|--------|------------|
| 1 halaman = 1 file | `loginPage.robot`, `cartPage.robot`, dst. |
| Locator hanya di POM | Jangan define locator di test case atau common |
| Keyword hanya interaksi UI | Tidak ada logic bisnis di POM |
| Tidak ada test data di POM | Data hanya dari argument atau variabel global |
| Import `AppiumLibrary` | Setiap POM wajib import `AppiumLibrary` |

### Contoh Pembuatan POM Baru

Misal halaman **Payment**:
```robot
# resources/POM/paymentPage.robot
*** Settings ***
Library    AppiumLibrary

*** Variables ***
${FIELD_CARD_NUMBER}    accessibility_id=test-Card Number
${BTN_PAY}              accessibility_id=test-PAY
${LBL_TOTAL}            accessibility_id=test-Total

*** Keywords ***
Isi Nomor Kartu
    [Arguments]    ${card_number}
    Input Text    ${FIELD_CARD_NUMBER}    ${card_number}

Klik Bayar
    Click Element    ${BTN_PAY}
```

---

## 4. DDT (Data-Driven Testing)

### Format JSON Standar

```json
{
    "namaScenario": {
        "field_1": "value_1",
        "field_2": "value_2"
    }
}
```

### Aturan DDT

| Aturan | Penjelasan |
|--------|------------|
| Data di `.json` | Semua test data disimpan di `resources/dataFiles/` |
| Key = nama scenario | Key JSON harus deskriptif: `validLogin`, `invalidLogin` |
| Load sekali | Di `Suite Setup`, bukan di setiap test |
| Akses via dictionary | `${DATA['scenario']['field']}` |

### Menambah Data Baru

**Step 1** — Buat JSON di `resources/dataFiles/`:
```json
{
    "scenarioA": { "field": "value_a" },
    "scenarioB": { "field": "value_b" }
}
```

**Step 2** — Tambah variabel di `common.robot`:
```robot
${JSON_NEW_PATH}    ${BASE_PATH}/resources/dataFiles/newData.json
${NEW_DATA}         ${None}
```

**Step 3** — Update `Load All Test Data`:
```robot
Load All Test Data
    # ... existing loads ...
    ${data_new}=    Load Json From File    ${JSON_NEW_PATH}
    Set Suite Variable    ${NEW_DATA}    ${data_new}
```

**Step 4** — Akses di test case:
```robot
TC03001 - Scenario baru
    [Setup]    Setup Login App    validLogin
    Isi Form Baru    ${NEW_DATA['scenarioA']['field']}
    [Teardown]    Close Application
```
