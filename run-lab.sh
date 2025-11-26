#!/bin/bash
# Set all variables to start de script
PROJECT=$(gcloud config get-value project)
BUCKET_NAME="$PROJECT-bucket"
REGION="Multi-Region"
ZONE="us-east1-c"
IMAGE_NAME="sample.txt"
IMAGE_NAME_RENAMED="ada-renamed.txt"
FOLDER_NAME="image-folder"

echo "gcloud auth list and proy"
gcloud auth list
gcloud config list project

# Create a BUCKET by command line
echo "Create a BUCKET by command line"
gcloud storage buckets create gs://$BUCKET_NAME --location=$REGION

# move image to test the service in Bucket via cloud
echo "download and upload images to bucket"
curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output $IMAGE_NAME
gcloud storage cp $IMAGE_NAME gs://$BUCKET_NAME
rm $IMAGE_NAME

# Download again the image from bucket to local
gcloud storage cp -r gs://$BUCKET_NAME/$IMAGE_NAME .
echo "image dounloaded"
ls

# Rename file on the bucket
gsutil mv gs://$BUCKET_NAME/$IMAGE_NAME gs://$BUCKET_NAME/$IMAGE_NAME_RENAMED

# List all the files on the bucket
gcloud storage ls gs://$BUCKET_NAME

# list detalles oll the files on the bicket
gcloud storage ls -l gs://$BUCKET_NAME/$IMAGE_NAME

