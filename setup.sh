#!/bin/bash

#
# A script to setup the s3 bucket for tf state and dynamo db for terrafor stuff
#

# Function to display usage information
usage() {
    echo "Usage: $0 -a AWS_ACCOUNT -p AWS_PROFILE -r AWS_REGION -e AWS_ENVIRONMENT"
    echo "  -a AWS_ACCOUNT      12-digit AWS account number"
    echo "  -p AWS_PROFILE      AWS CLI profile name"
    echo "  -r AWS_REGION       AWS region code"
    echo "  -e AWS_ENVIRONMENT  Short string for environment (3 characters ideal)"
    exit 1
}

# Parse command line arguments
while getopts "a:p:r:e:" opt; do
    case "${opt}" in
        a)
            AWS_ACCOUNT=${OPTARG}
            ;;
        p)
            AWS_PROFILE=${OPTARG}
            ;;
        r)
            AWS_REGION=${OPTARG}
            ;;
        e)
            AWS_ENVIRONMENT=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

# Check if all required arguments are provided
if [ -z "${AWS_ACCOUNT}" ] || [ -z "${AWS_PROFILE}" ] || [ -z "${AWS_REGION}" ] || [ -z "${AWS_ENVIRONMENT}" ]; then
    usage
fi

# Export the variables to the environment
export AWS_ACCOUNT
export AWS_PROFILE
export AWS_REGION
export AWS_ENVIRONMENT

# Display the variables
echo "AWS_ACCOUNT=${AWS_ACCOUNT}"
echo "AWS_PROFILE=${AWS_PROFILE}"
echo "AWS_REGION=${AWS_REGION}"
echo "AWS_ENVIRONMENT=${AWS_ENVIRONMENT}"

AWS_S3_BUCKET="${AWS_ACCOUNT}-terraform-tfstate-${AWS_ENVIRONMENT}"
aws s3api create-bucket --bucket $AWS_S3_BUCKET --region $AWS_REGION --profile $AWS_PROFILE --create-bucket-configuration LocationConstraint=$AWS_REGION

AWS_DYNAMODB_TABLE="terraform-state-lock-${AWS_ENVIRONMENT}"
aws dynamodb create-table --profile $AWS_PROFILE --region $AWS_REGION --table-name $AWS_DYNAMODB_TABLE  \
               --attribute-definitions AttributeName=LockID,AttributeType=S  \
               --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput  \
               ReadCapacityUnits=1,WriteCapacityUnits=1


# example: ./setup.sh -a 999999999999 -p default -r eu-west-1 -e CLUSTERNAME