*update: now it works over SSL thanks to [Let's Encrypt](https://letsencrypt.org/)*

# Password Generator

*Motivation*: A quick way to create random password without installing anything!

## How to by example:
- Create one password of XX chars long: `curl -L pwgen.borisquiroz.dev/20`
- Create XX passwords of YY chars long: `curl -L pwgen.borisquiroz.dev/40/5`

So this thing basically receives two parameters: length and count. A few
examples:

```
➜ curl -L pwgen.borisquiroz.dev/40
oWVh743gZZkIgYL5NKxwJL$DHCT8T74Z9CNBuZRv
➜ curl -L pwgen.borisquiroz.dev/25/2
CHraelyUiGyAhNC)yyoOxFnv9
KfHg5Z8%JD5oJHw68BdB3sCD4
```

## Real life example (a.k.a. live-demo):

This code is currently running on a docker, available at
[pwgen.borisquiroz.dev](https://pwgen.borisquiroz.dev). You can use it to generate your passwords
following examples above.

## Dockerize all the things!
`docker run -d boris/pwgen-web` available on [Docker
Hub](https://hub.docker.com/r/boris/pwgen-web/)

## Running locally
```
git clone https://github.com/boris/pwgen.git
cd pwgen
pip install -r requirements.txt
python manage.py runserver
```

## Running in production
What you see at [pwgen.borisquiroz.dev](https://pwgen.borisquiroz.dev) is currently running in
kubernetes using ArgoCD, which deploys everything under `kubernetes` directory.
