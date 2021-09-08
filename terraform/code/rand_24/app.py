from pwgen import pwgen
import json

def lambda_handler(event, context):
    length = event['pathParameters']['proxy'].split('/')[0]
    count = event['pathParameters']['proxy'].split('/')[1]

    if not count:
        passwd = pwgen(int(length),
                symbols=False,
                )
    else:
        passwd = pwgen(int(length),
                int(count),
                symbols=False,
                )
    return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/json'  },
            'body': json.dumps({
                'value': passwd,
                'path': event['pathParameters'],
                })
            }

def hello_world(event, context):
    return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/text'},
            'body': json.dumps({
               'message' : 'hello world!'
               })
            }
