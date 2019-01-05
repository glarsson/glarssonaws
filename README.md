glarssonaws

An example of how to manage a highly available (three separate locations at once) dotnet core application
on AWS using, in this example, CentOS, AWS ELB, Aurora Cluster and dotnet core 2.1 for Linux

Instructions to use:

1) Download terraform, make sure its in %PATH%

2) Download git - https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe

3) Download aws cli - https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi

4) Run ‘aws configure’ to configure AWS credentials - for this example please use region "eu-north-1"

5) Create c:\source (or whatever you want) and cd into it

6) Open git bash and run ‘git clone https://github.com/glarsson/glarssonaws.git’ in /c/source

TO BRING UP TEST
“cd” into ./glarssonaws/terraform/test and run:
	Terraform init
	Terraform plan
	Terraform apply

TO BRING UP STAGING
“cd” into ./glarssonaws/terraform/staging and run:
	Terraform init
	Terraform plan
	Terraform apply

TO BRING UP PRODUCTION
<coming...>




Thoughts, considerations, issues;
Need to make sure all private instances start after network is available
Are tags set for all resources?
Sg’s setup properly?
Add DNS entries for internal/private servers


