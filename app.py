# def lambda_handler(event, context):
#     return {
#         'statusCode': 200,
#         'body': 'Hello from Lambda!'
#     }

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda with LAMBDA with new image from ECR!'
    }