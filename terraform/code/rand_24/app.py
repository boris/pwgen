from pwgen import pwgen
import json

def lambda_handler(event, context):
    passwd = pwgen(42,
            symbols=False,
            )
    return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/json'  },
            'body': json.dumps({
                'value': passwd,
                'path': event,
                })
            }

def hello_world(event, context):
    return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/json'},
            'body': json.dumps({
               'message' : 'hello world!'
               })
            }
