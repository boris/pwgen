FROM python:3.8.1-alpine

RUN apk update
RUN apk add python3-dev build-base linux-headers pcre-dev

RUN mkdir /code
WORKDIR /code
EXPOSE 5000

ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

CMD ["python", "app.py"]
