FROM python:3.8

WORKDIR /bot

ARG bot_token 
ARG api_key

ENV BOT_TOKEN=$token
ENV API_KEY=$api_key

COPY requirements.txt /bot/requirements.txt

COPY . /bot

RUN pip install -r ./requirements.txt
EXPOSE 80
CMD ["python", "bot.py"]

