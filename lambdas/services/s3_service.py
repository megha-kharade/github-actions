import boto3
from botocore.exceptions import ClientError


s3 = boto3.client("s3")

def download_file(bucket_name, object_key, download_path):
    try:
         print("Services package loaded")
        # s3.download_file(bucket_name, object_key, download_path)
        # print(f"Downloaded {object_key} to {download_path}")

    except ClientError as error:
        print(f"Error downloading file: {error}")
        raise