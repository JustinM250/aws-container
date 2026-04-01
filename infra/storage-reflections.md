3.1. Read about pre-signed S3 URLs. Read the comments in app/flask/photos.py:get_presigned_url. Explain how your app allows users to upload and view photos in your S3 bucket despite the fact that objects in S3 buckets are private by default and you did NOT apply any policies that would override that default. 

    As the comment says, ANYONE with the URL can access it despite not having access to the private bucket. This approach is used to allow our end users to view photos through the app in safe/controlled manner. After a certain time period, the URL expires. 

3.2. Read about Global Secondary Indexes. Explain why the two GSIs you created are useful, and why the specific attributes used for the hash and range keys are the right choices for those GSIs. It may be helpful to read the comments in the upload_photo and toggle_privacy functions in app/flask/photos.py

    "The partition key of an item is also known as its hash attribute." - AWS Docs
    "The sort key of an item is also known as its range attribute. The term range attribute derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value." - AWS Docs

    An index is like a pre-saved view that speeds up read operations on future queries. The two Global Secondary Indexes are useful for when there are a larger # of photos on our app. We use uploaded_at for the range to sort by upload time, and the respective hash keys to store related photos in the same place (ie; we want the user's photos on the same partition, and all the feed photos to be on the same partition)