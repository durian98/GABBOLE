# README 이미지와 구성 기준

- 로고와 서비스 화면: GABOLLE 팀 발표 자료의 이미지 원본을 사용했습니다. 이미지를 새로 그리거나 서비스 화면을 합성하지 않았습니다.
- 이미지 선택 기준: 서비스 홈, 여행 조건 입력, 코스 결과, 여행 중 일정, AI 도우미와 여행 기록의 흐름을 보여 주는 화면입니다.
- 파일 대응: `logo.png` ← `logo.png`, `home-web.jpg` ← `live-home-desk.jpg`, `trip-create.jpg` ← `scr-create.jpg`, `course-candidates.jpg` ← `scr-courses.jpg`, `trip-timeline.jpg` ← `scr-trip.jpg`, `assistant.jpg` ← `scr-chat.jpg`, `travel-tools.jpg` ← `ai-pop.jpg`, `feed.jpg` ← `live-feed.jpg`.
- `architecture.svg`: 보관한 `main@2d4f4f634`의 코드와 설정을 바탕으로 README용으로 작성한 개략도입니다. 실제 운영 서버의 배치도나 외부 서비스의 현재 가용성을 나타내지 않습니다. 기술 로고는 배경이 투명한 SVG 원본을 사용하며, 구성도 안에 벡터 경로를 직접 포함했습니다. 개별 원본과 이용조건은 [아이콘 출처](icons/SOURCES.md)에 정리했습니다.
- 작성·코드 대조: 2026-10-20. 화면의 촬영 날짜와 해당 앱 빌드가 기준 커밋과 정확히 일치하는지는 별도로 확인하지 않았습니다.

개인 담당 범위는 기존 프로젝트 기록과 작성자 `jaehyeon`의 초기 구현 커밋 `59e92e1a7`(인증), `de403d3de`(일정 생성), `0c75f5ce2`(기록·피드), `90393f915`(동행·공유), `396ea1c1d`(경로 API)를 대조했습니다. 이후 데이터·추천·교통 경로와 이벤트 처리의 확장은 팀 구현으로 설명합니다.
