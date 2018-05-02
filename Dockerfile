FROM python:3.6.1-alpine

RUN mkdir /code
WORKDIR /code
EXPOSE 443

ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

CMD ["python", "app.py"]
