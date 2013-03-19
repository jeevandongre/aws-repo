#! /bin/bash
##The inspiration for writing this script goes to MR.Eric Hammond
##of alestic.com, inspiration article link http://alestic.com/2012/09/aws-command-line-tools


##if you have not installed Java in your instance this will install the Oracle Sun Java 6 using apt-repo
##uncomment the below lines if you have already installed java
sudo add-apt-repository ppa:sun-java-community-team/sun-java6
sudo apt-get update
sudo apt-get install sun-java6-jre
###################################################################################
########### Installs aws ec2-api-tools ############################################
echo "installing aws ec2-api-tools"
wget --quiet http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
unzip -qq ec2-api-tools.zip
#creates dir 
sudo mkdir /usr/local/aws/ec2
sudo /usr/bin/rsync  -a --no-o --no-g ec2-api-tools-*/ /usr/local/aws/ec2/
###########################################################################################
############Installs the aws ec2-ami-tools##########################################
echo "installing aws ec2-ami-tools"
wget --quiet http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.zip
unzip -qq ec2-ami-tools.zip
sudo /usr/bin/rsync -a --no-o --no-g ec2-ami-tools-*/ /usr/local/aws/ec2/
#######################################################################################
###################Installs the S3 command line tools ################################3
echo "installing aws s3"
wget --quiet http://s3.amazonaws.com/doc/s3-example-code/s3-curl.zip
unzip -qq s3-curl.zip
sudo mkdir -p /usr/local/aws/s3/bin/
sudo /usr/bin/rsync -a --no-o --no-g s3-curl/ /usr/local/aws/s3/bin/
sudo chmod 755 /usr/local/aws/s3/bin/s3curl.pl
################################################################################
echo "installing aws IAM"
wget --quiet http://awsiammedia.s3.amazonaws.com/public/tools/cli/latest/IAMCli.zip
unzip -qq IAMCli.zip
sudo /usr/bin/rsync -a --no-o --no-g IAMCli-*/ /usr/local/aws/iam/
################################################################################
echo "installing aws RDS"
wget --quiet http://s3.amazonaws.com/rds-downloads/RDSCli.zip
unzip -qq RDSCli.zip
sudo rsync -a --no-o --no-g RDSCli-*/ /usr/local/aws/rds/
################################################################################
echo "installing aws ELB"
wget --quiet http://ec2-downloads.s3.amazonaws.com/ElasticLoadBalancing.zip
unzip -qq ElasticLoadBalancing.zip
sudo /usr/bin/rsync -a --no-o --no-g ElasticLoadBalancing-*/ /usr/local/aws/elb/
################################################################################

echo "installing aws CF"
wget --quiet https://s3.amazonaws.com/cloudformation-cli/AWSCloudFormation-cli.zip
unzip -qq AWSCloudFormation-cli.zip
sudo /usr/bin/rsync -a --no-o --no-g AWSCloudFormation-*/ /usr/local/aws/cfn/
################################################################################

echo "installing aws auto scaling"
wget --quiet http://ec2-downloads.s3.amazonaws.com/AutoScaling-2011-01-01.zip
unzip -qq AutoScaling-*.zip
sudo /usr/bin/rsync -a --no-o --no-g AutoScaling-*/ /usr/local/aws/as/
################################################################################
echo "installing aws cloud watch"
wget --quiet http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip
unzip -qq CloudWatch-*.zip
sudo /usr/bin/rsync -a --no-o --no-g CloudWatch-*/ /usr/local/aws/cloudwatch/
################################################################################
echo "installing aws sns"
wget --quiet http://sns-public-resources.s3.amazonaws.com/SimpleNotificationServiceCli-2010-03-31.zip
unzip -qq SimpleNotificationServiceCli-*.zip
sudo /usr/bin/rsync -a --no-o --no-g SimpleNotificationServiceCli-*/ /usr/local/aws/sns/
sudo chmod 755 /usr/local/aws/sns/bin/*
################################################################################

mkdir -m 0700 $HOME/.aws-default/
echo "wrting ~/.aws-defaults/"
echo "AWSAccessKeyId=<insert your AWS access id here>" > / "AWSSecretKey=<insert your AWS secret access key here>" ~/.aws-default/aws-credential-file.txt

echo "%awsSecretAccessKeys = (" / "'default' => {" / "id => '<insert your AWS access id here>'," / "key => '<insert your AWS secret access key here>'," / "}." / ");"
 
################################################################################
echo  "export JAVA_HOME=/usr" >> ~/.bashrc
echo "export EC2_HOME=/usr/local/aws/ec2" >> ~/.bashrc
echo "export AWS_IAM_HOME=/usr/local/aws/iam" >> ~/.bashrc
echo "export AWS_RDS_HOME=/usr/local/aws/rds" >> ~/.bashrc
echo "export AWS_ELB_HOME=/usr/local/aws/elb" >> ~/.bashrc
echo "export AWS_CLOUDFORMATION_HOME=/usr/local/aws/cfn" >> ~/.bashrc
echo "export AWS_AUTO_SCALING_HOME=/usr/local/aws/as >>" ~/.bashrc
echo "export CS_HOME=/usr/local/aws/cloudsearch" >> ~/.bashrc
echo "export AWS_CLOUDWATCH_HOME=/usr/local/aws/cloudwatch" >> ~/.bashrc
echo "export AWS_SNS_HOME=/usr/local/aws/sns" >> ~/.bashrc
echo "export AWS_ROUTE53_HOME=/usr/local/aws/route53" >> ~/.bashrc
echo "export AWS_CLOUDFRONT_HOME=/usr/local/aws/cloudfront"  >> ~/.bashrc

################################################################################

for i in $EC2_HOME $AWS_IAM_HOME $AWS_RDS_HOME $AWS_ELB_HOME   $AWS_CLOUDFORMATION_HOME $AWS_AUTO_SCALING_HOME $CS_HOME   $AWS_CLOUDWATCH_HOME $AWS_ELASTICACHE_HOME $AWS_SNS_HOME   $AWS_ROUTE53_HOME $AWS_CLOUDFRONT_HOME /usr/local/aws/s3
do
  PATH=$i/bin:$PATH
done
################################################################################

echo "export EC2_PRIVATE_KEY=$(echo $HOME/.aws-default/pk-*.pem)" >> ~/.bashrc
echo "export EC2_CERT=$(echo $HOME/.aws-default/cert-*.pem)" >> ~/.bashrc
echo "export AWS_CREDENTIAL_FILE=$HOME/.aws-default/aws-credential-file.txt" >> ~/.bashrc

source ~/.bashrc
