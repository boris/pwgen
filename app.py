from pwgen import pwgen
from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html')

@app.route('/<int:length>/<int:count>')
def generate_random(length, count):
    return "\n".join(pwgen(length, count)) + "\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
