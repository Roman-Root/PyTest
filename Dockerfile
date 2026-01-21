FROM python:3.12-alpine AS builder

WORKDIR /app

RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    tzdata \
    libstdc++ \
    curl \
    && rm -rf /var/cache/apk/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.12-alpine

WORKDIR /app

COPY --from=builder /usr/bin/chromium-browser /usr/bin/
COPY --from=builder /usr/bin/chromedriver /usr/bin/
COPY --from=builder /usr/lib/chromium/* /usr/lib/chromium/
COPY --from=builder /usr/lib/libstdc++* /usr/lib/

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY . .

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROMEDRIVER_PATH=/usr/bin/chromedriver

RUN wget -q https://github.com/allure-framework/allure2/releases/download/2.29.0/allure-2.29.0.tgz -O allure.tgz \
    && tar -zxvf allure.tgz -C /opt/ \
    && ln -s /opt/allure-2.29.0/bin/allure /usr/bin/allure \
    && rm allure.tgz

CMD ["pytest", "-v", "--alluredir=allure-results"]