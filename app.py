from pwgen import pwgen
from flask import Flask
from flask import render_template
from flask import Response

app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html')

@app.route('/healthz')
def healthz():
    return Response("OK", status=200)

@app.route('/<int:length>')
def default_usage(length):
    passwd = pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"
    return Response(passwd, mimetype="text/plain")

@app.route('/<int:length>/<int:count>')
def generate_random(length, count):
    if count == 1:
        passwd = pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"
        return Response(passwd, mimetype="text/plain")
    else:
        passwd = "\n".join(pwgen(length, count, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|")) + "\n"
        return Response(passwd, mimetype="text/plain")

@app.route('/vault')
def generate_id():
    a = pwgen(8, symbols=False, no_capitalize=True)
    b = pwgen(4, symbols=False, no_capitalize=True)
    c = pwgen(4, symbols=False, no_capitalize=True)
    d = pwgen(4, symbols=False, no_capitalize=True)
    e = pwgen(12, symbols=False, no_capitalize=True)

    token =  a + "-" + b + "-" + c + "-" + d + "-" + e + "\n"
    return Response(token, mimetype="text/plain")

@app.route('/donate')
def sutmm():
    return render_template('donate.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0')
