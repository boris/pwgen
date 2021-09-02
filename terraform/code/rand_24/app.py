from pwgen import pwgen
import json

def lambda_handler(event, context):
    passwd = pwgen(24,
            symbols=True,
            )
    return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/json'  },
            'body': json.dumps({
                'value': passwd
                })
            }

