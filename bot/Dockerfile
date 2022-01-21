FROM python:3.8

WORKDIR /bot

COPY requirements.txt /bot/requirements.txt

COPY . /bot

RUN pip install -r ./requirements.txt
EXPOSE 80
CMD ["python", "bot.py"]

