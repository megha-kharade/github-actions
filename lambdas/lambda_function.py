from services import download_file

def lambda_handler(event, context):

    bucket = "my-demo-bucket"

    key = "customers/customer.csv"

    destination = "/tmp/customer.csv"

    download_file(
        bucket,
        key,
        destination
    )

    print("Processing completed.")

    return {
        "statusCode": 200,
        "body": "Success"
    }