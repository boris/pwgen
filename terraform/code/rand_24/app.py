from pwgen import pwgen
import json

def lambda_handler(event, context):
    passwd = pwgen(event['length'],
            symbols=True,
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
