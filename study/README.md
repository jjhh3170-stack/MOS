# 📚 반도체공학 MOSFET 기말 공부 (Kiro와 함께)

이 폴더는 Kiro와 MOSFET(물리전자 10·11장)을 공부한 기록입니다.

## 파일
- **PROGRESS.md** — 공부 진도. 새 세션에서 Kiro가 먼저 읽고 이어서 진행.
- **STUDY_NOTES.md** — 지금까지 정리한 필기(개념·공식·암기 포인트).
- **setup_and_convert.sh** — 환경 셋업 + PDF를 PNG로 렌더링(교재가 스캔본이라 필요).

## 새 세션에서 이어서 공부하는 법
Kiro에게 이렇게 말하면 됩니다:
> "저장소 study/PROGRESS.md 읽고 이어서 공부하자"

그러면 Kiro가:
1. `bash study/setup_and_convert.sh` 로 PNG 재생성
2. PROGRESS.md의 "다음 시작 지점"부터 설명 재개
3. 새 내용은 STUDY_NOTES.md에 추가하고 진도 갱신

## 왜 변환 스크립트가 필요한가
교재 PDF(물리전자 10·11장)는 **텍스트 레이어 없는 스캔 이미지**라 그냥 읽으면 내용이 안 나옵니다.
→ PyMuPDF로 페이지를 PNG로 렌더링한 뒤 이미지로 읽습니다.
