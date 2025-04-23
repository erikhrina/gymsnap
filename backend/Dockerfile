FROM python:3.10.16-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libffi-dev \
    openssl \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python3", "run.py"]