FROM python:3.12-slim

WORKDIR /app


RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    ca-certificates \
    fonts-liberation \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


RUN wget -q https://github.com/allure-framework/allure2/releases/download/2.29.0/allure-2.29.0.tgz \
    && tar -zxvf allure-2.29.0.tgz -C /opt/ \
    && ln -s /opt/allure-2.29.0/bin/allure /usr/bin/allure \
    && rm allure-2.29.0.tgz

COPY . .

ENV CHROME_BIN=/usr/bin/chromium \
    CHROMEDRIVER_PATH=/usr/bin/chromedriv_
