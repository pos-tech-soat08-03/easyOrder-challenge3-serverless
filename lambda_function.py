import json
import pymysql
import os

def lambda_handler(event, context):

    print("ENVIRONMENT VARIABLES")

    rds_host = os.environ['RDS_HOST']
    name = os.environ['RDS_USERNAME']
    password = os.environ['RDS_PASSWORD']
    db_name = os.environ['RDS_DB_NAME']

    print(f"RDS_HOST: {rds_host}")
    print(f"RDS_USERNAME: {name}")
    print(f"RDS_PASSWORD: {password}")
    print(f"RDS_DB_NAME: {db_name}")
    
    # connection = pymysql.connect(host=rds_host, user=name, passwd=password, db=db_name)
    
    # cpf = event['cpf']
    
    # with connection.cursor() as cursor:
    #     cursor.execute("SELECT * FROM users WHERE cpf = %s", (cpf,))
    #     result = cursor.fetchone()
    
    # connection.close()

    result = {
        'name': 'John Doe',
        'cpf': '123.456.789-00',
        'email': 'test@test.com',
    }
    
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }