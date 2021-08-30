from pwgen import pwgen

def lambda_handler(event, context):
    passwd = pwgen(24,
            symbols=True,
            )
    return passwd

