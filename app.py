from pwgen import pwgen
from flask import Flask
from flask import render_template
from flask import Response
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from prometheus_client import make_wsgi_app, Counter, Gauge
import subprocess
import docker

app = Flask(__name__)
app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
    '/metrics': make_wsgi_app()
    })

single_count = Counter('single_requests', 'Requests of single passwd')
multi_count = Counter('multi_requests', 'Requests of multiple passwds')
str_single_count = Counter('str_single', 'Requests of string-only single passwd')
str_multi_count = Counter('str_multi', 'Requests of string-only multi passwd')

short_hash = str(subprocess.check_output(['git', 'rev-parse', '--short', 'HEAD']),'utf-8').strip()

@app.route('/')
def hello_world():
    return render_template('index.html',short_hash=short_hash)

@app.route('/healthz')
def healthz():
    return Response(f"Current version: {short_hash}.", status=200)

@app.route('/<int:length>')
def default_usage(length):
    passwd = pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"
    single_count.inc()
    return Response(passwd, mimetype="text/plain")

@app.route('/str/<int:length>')
def generate_one_string(length):
    passwd = pwgen(length, no_numerals=True, symbols=False) + "\n"
    str_single_count.inc()
    return Response(passwd.upper(), mimetype="text/plain")

@app.route('/str/<int:length>/<int:count>')
def generate_string(length, count):
    if count == 1:
        passwd = pwgen(length, no_numerals=True, symbols=False) + "\n"
        str_single_count.inc()
        return Response(passwd.upper(), mimetype="text/plain")
    else:
        passwd = "\n".join(pwgen(length, count, no_numerals=True, symbols=False)) + "\n"
        str_multi_count.inc()
        return Response(passwd.upper(), mimetype="text/plain")

@app.route('/<int:length>/<int:count>')
def generate_random(length, count):
    if count == 1:
        passwd = pwgen(length, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|") + "\n"
        single_count.inc()
        return Response(passwd, mimetype="text/plain")
    else:
        passwd = "\n".join(pwgen(length, count, symbols=True, allowed_symbols="!@#$%^&*()_-=+,.<>/?;:{}[]\|")) + "\n"
        multi_count.inc()
        return Response(passwd, mimetype="text/plain")

@app.route('/docker')
def docker_name():
    left = docker.left()
    right = docker.right()
    name = "{} {}".format(left, right)
    return Response(name, mimetype="text/plain")

@app.route('/donate')
def sutmm():
    return render_template('donate.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
