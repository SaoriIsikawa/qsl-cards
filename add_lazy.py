from bs4 import BeautifulSoup
from pathlib import Path
import sys
import glob

files = []
for arg in sys.argv[1:]:
    files.extend(glob.glob(arg))

if not files:
    print("No HTML files found.")
    sys.exit(1)

for html_file in files:
    path = Path(html_file)
    soup = BeautifulSoup(path.read_text(encoding="utf-8"), "lxml")

    for img in soup.find_all("img"):
        if not img.has_attr("loading"):
            img["loading"] = "lazy"
        if not img.has_attr("decoding"):
            img["decoding"] = "async"

    path.write_text(str(soup), encoding="utf-8")
    print(f"✔ Updated {path}")
