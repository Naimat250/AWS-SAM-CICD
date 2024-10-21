#create an S3 bucket
aws s3 mb s3://naimat-sam-code

#package cloudformation to S3
aws cloudformation package --s3-bucket naimat-sam-code --template-file template.yaml --output-template-file gen/template-generate.yaml

#deploy to Cloudformation from S3
aws cloudformation deploy --template-file gen\template-generate.yaml --stack-name  hello-world-SAM --capabilities CAPABILITY_IAM

#init sam templete CICD 
sam init --location gh:aws-samples/cookiecutter-aws-sam-pipeline

#GitHub repo Configurations
aws ssm put-parameter --name "/service/sam-cicd/github/repo" --description "Github Repository name for Cloudformation Stack aws-sam-pipeline-pipeline" --type "String" --value "AWS-Serverless-CICD-SAM" --overwrite
aws ssm put-parameter --name "/service/sam-cicd/github/token" --description "Github Token for Cloudformation Stack aws-sam-pipeline-pipeline" --type "String" --value "" --overwrite
aws ssm put-parameter --name "/service/sam-cicd/github/user" --description "Github Username for Cloudformation Stack aws-sam-pipeline-pipeline" --type "String" --value "Naimat250" --overwrite

#Cloudformation Stack
aws cloudformation create-stack --stack-name aws-sam-pipeline-pipeline --template-body file://pipeline.yaml --capabilities CAPABILITY_NAMED_IAM
