from pathlib import Path

BASE_DIR = Path(__file__).parent
INPUT = BASE_DIR / "font-awesome-icons-names.txt"
OUTPUT = BASE_DIR / "font-awesome-icons-table.md"

icons = [
    line.strip()
    for line in INPUT.read_text(encoding="utf-8").splitlines()
    if line.strip() and not line.startswith("#")
]

with OUTPUT.open("w", encoding="utf-8") as f:
    f.write("| Ikona | Klasa | Kod |\n")
    f.write("|-------|-------|-----|\n")

    for cls in icons:
        html = f'<i class="{cls}"></i>'
        escaped = html.replace("<", "&lt;").replace(">", "&gt;")
        f.write(f"| {html} | `{cls}` | `{escaped}` |\n")

print(f"Wygenerowano {len(icons)} ikon → {OUTPUT}")
