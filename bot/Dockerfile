FROM alpine:latest
#FROM python:3.8
WORKDIR /bot

ARG bot_token
ARG api_key

ENV BOT_TOKEN=$bot_token
ENV API_KEY=$api_key

RUN env | grep "BOT_TOKEN"
RUN env | grep "API_KEY"
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

COPY requirements.txt /bot/requirements.txt

COPY . /bot

RUN pip install -r ./requirements.txt
EXPOSE 80
CMD ["python", "bot.py"]
