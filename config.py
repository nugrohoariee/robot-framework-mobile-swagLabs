# import os
# import socket

# BASE_PATH = ""

# hostname = socket.gethostname()

# if hostname == "DESKTOP-4N88NFD":
#     BASE_PATH = "E:/KERJA RIO/RND"
# else:
#     BASE_PATH = "D:/RND/ROBOT-MOBILE"


from pathlib import Path

# Path(__file__) adalah path ke file config.py ini.
# .resolve() memastikan kita mendapatkan path absolut (lengkap).
CURRENT_FILE_PATH = Path(__file__).resolve()

# BASE_PATH akan berisi folder tempat file config.py ini berada.
# Jika config.py ada di root project, maka ini adalah root-nya.
BASE_PATH = CURRENT_FILE_PATH.parent

# --- CONTOH PENGGUNAAN ---
# Jika kamu ingin mengambil path folder 'app' atau 'drivers' di dalam project:
# APP_PATH = BASE_PATH / "app" / "myshopify.apk"
# LOG_PATH = BASE_PATH / "results" / "logs"

# Jika kamu butuh string (karena beberapa library butuh string, bukan object Path):
# BASE_PATH_STR = str(BASE_PATH)