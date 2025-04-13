# Ubuntu 최신 이미지 기반
FROM ubuntu:latest

# 유지관리자 정보
LABEL maintainer="SOOYEONCHOI <chltndus1462@gmail.com>"

# 작업 디렉토리 생성
WORKDIR /mlops

# 현재 디렉토리의 모든 파일을 작업 디렉토리로 복사
COPY . .

# Python 및 빌드 도구 설치 (uvicorn 의존성 포함)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    libffi-dev \
    libssl-dev \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# pip 업그레이드는 생략하고 패키지만 설치 (PEP 668 우회)
RUN python3 -m pip install fastapi uvicorn --break-system-packages

# FastAPI 앱 포트 노출
EXPOSE 8000

# FastAPI 앱 실행
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]

