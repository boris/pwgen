from pwgen import pwgen
from flask import Flask
from flask import render_template

app = Flask(__name__)

passwds = []

@app.route('/')
def hello_world():
    return render_template('index.html')

@app.route('/<int:length>')
def default_usage(length):
    return pwgen(length) + "\n"

@app.route('/<int:length>/<int:count>')
def generate_random(length, count):
    passwds.append(pwgen(length, count))
    return passwds


if __name__ == "__main__":
    app.run(host='0.0.0.0')
