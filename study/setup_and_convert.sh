#!/usr/bin/env bash
# MOSFET 공부용 환경 셋업 + PDF -> PNG 변환 스크립트
# 교재 PDF가 스캔 이미지라 텍스트 추출이 안 되므로, 페이지를 PNG로 렌더링해 이미지로 읽는다.
#
# 사용법 (저장소 루트에서):
#   bash study/setup_and_convert.sh
#
# 주의:
#  - /root/.local/lib 가 읽기전용이라 pip --target 로 워크스페이스에 설치한다.
#  - 한글 파일명은 bash heredoc 에 직접 넣으면 깨지므로 python glob 로 고른다.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"
LIBS="$REPO_DIR/.pylibs"

echo "== 1) PyMuPDF 설치 (워크스페이스 .pylibs) =="
if ! PYTHONPATH="$LIBS" python3 -c "import fitz" 2>/dev/null; then
  mkdir -p "$LIBS"
  python3 -m pip install --no-input --target="$LIBS" "PyMuPDF==1.24.10"
fi
PYTHONPATH="$LIBS" python3 -c "import fitz; print('   PyMuPDF', fitz.VersionBind, 'OK')"

echo "== 2) PDF -> PNG 렌더링 =="
PYTHONPATH="$LIBS" python3 - <<'PY'
import fitz, glob, os

def render(pdf, outdir, dpi=130, prefix="p"):
    doc = fitz.open(pdf)
    os.makedirs(outdir, exist_ok=True)
    for i, page in enumerate(doc):
        page.get_pixmap(dpi=dpi).save(f"{outdir}/{prefix}{i+1:02d}.png")
    print(f"   {pdf}: {doc.page_count}p -> {outdir}/")

pdfs = glob.glob("*.pdf")
# KHU 슬라이드
for f in pdfs:
    if "Part1" in f:  render(f, "ch10p1", dpi=120, prefix="slide_")
    if "Part2" in f:  render(f, "ch10p2", dpi=120, prefix="slide_")
    if "CH11" in f or "Additional" in f: render(f, "ch11khu", dpi=120, prefix="slide_")
# 교재 (한글 파일명 = 비ASCII)
for f in pdfs:
    if any(ord(c) > 127 for c in f):
        if "10" in f: render(f, "tb10", dpi=130)
        if "11" in f: render(f, "tb11", dpi=130)
print("   DONE")
PY

echo "== 완료. ch10p1/, tb10/, tb11/ 등에서 PNG 확인 =="
