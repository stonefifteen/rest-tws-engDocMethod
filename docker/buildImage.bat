@ECHO OFF
@REM This script uses an Amazon AMI in conjunction with the Dockerfile, to allow for the
@REM generated container to run either in Docker on the local machine, or else in AWS ECS or Fargate.

@REM To ensure that the required AMI is installed locally by Docker as an available image, 
@REM you will need to execute two commands; the first will be to login to the
@REM AWS public Elastic Container Registry (ECR), the second will be to tell Docker to download (pull)
@REM the image to the local machine.

@REM Prior to logging in, the AWS root account or IAM user must have these privileges:
@REM    ecr-public:GetAuthorizationToken
@REM    sts:GetServiceBearerToken

@REM Obtain an AWS public ECR password using the AWS CLI, redirecting to a file or whatever method
@REM which allows an environment variable to be set (in this example, AWS_ECR_PASSWORD):
@REM    aws ecr-public get-login-password --region us-east-1
@REM Copy the displayed password to the clipboard - in Windows 11 it does not work to save to a file
@REM and then set that file contents into the environment variable (the content gets truncated). Right-click
@REM paste the password to the end of this command (immediately to the right of the equals sign):
@REM    SET AWS_ECR_PASSWORD=
@REM Then run this commands to login the local Docker engine to the AWS public ECR:
@REM    docker login --username AWS --password %AWS_ECR_PASSWORD% public.ecr.aws

@REM Finally, run this command to download the image:
@REM    docker pull public.ecr.aws/amazonlinux/amazonlinux:latest


@REM docker build --progress=plain -t amazonlinux:latest %* . 
docker build --progress=plain -t ubuntu-antora %* . 
