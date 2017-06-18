FROM python:3.6.1-alpine

RUN mkdir /code
WORKDIR /code
ENV FLASK_APP=pwgen.py
EXPOSE 5000

ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

CMD ["flask", "run"]
