from pathlib import Path

BASE_DIR = Path(__file__).parent

INPUT = BASE_DIR / "icons-font-awesome-input.txt"
OUTPUT = BASE_DIR / "icons-font-awesome-output.md"

COLUMNS_MOBILE = 10
COLUMNS_DESKTOP = 20

# --- wczytanie ikon ---
icons = []

for raw in INPUT.read_text(encoding="utf-8").splitlines():
    line = raw.strip()
    if not line or line.startswith("#"):
        continue
    icons.append(line)

# usunięcie duplikatów z zachowaniem kolejności
icons = list(dict.fromkeys(icons))

# --- generowanie pliku ---
with OUTPUT.open("w", encoding="utf-8") as f:
    f.write("## Ikony\n\n")

    f.write("<style>\n")
    f.write(
        f".mps-fa-grid {{ display: grid; "
        f"grid-template-columns: repeat({COLUMNS_MOBILE}, 1fr); "
        f"gap: 0.6rem; }}\n"
    )
    f.write(
        f"@media (min-width: 768px) {{ "
        f".mps-fa-grid {{ grid-template-columns: repeat({COLUMNS_DESKTOP}, 1fr); }} "
        f"}}\n"
    )
    f.write(".mps-fa-grid span { text-align: center; font-size: 1.2rem; }\n")
    f.write("</style>\n\n")

    f.write('<div class="mps-fa-grid">\n')

    for cls in icons:
        f.write(
            f'  <span title="{cls}">'
            f'<i class="{cls}" aria-hidden="true"></i>'
            f'</span>\n'
        )

    f.write("</div>\n")

print(f"Wygenerowano {len(icons)} ikon → {OUTPUT}")
