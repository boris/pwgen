from pwgen import pwgen
from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html')

@app.route('/<int:length>')
def default_usage(length):
    return pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"

@app.route('/<int:length>/<int:count>')
def generate_random(length, count):
    if count == 1:
        return pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"
    else:
        return "\n".join(pwgen(length, count, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|")) + "\n"

@app.route('/vault')
def generate_id():
    a = pwgen(8, symbols=False, no_capitalize=True)
    b = pwgen(4, symbols=False, no_capitalize=True)
    c = pwgen(4, symbols=False, no_capitalize=True)
    d = pwgen(4, symbols=False, no_capitalize=True)
    e = pwgen(12, symbols=False, no_capitalize=True)

    return a + "-" + b + "-" + c + "-" + d + "-" + e + "\n"


if __name__ == "__main__":
    app.run(host='0.0.0.0')
