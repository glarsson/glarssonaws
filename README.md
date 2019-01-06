glarssonaws

An example of how to bring up a HA (highly available) dotnet core application
on AWS using, in this example, CentOS, AWS ELB, Aurora Cluster and dotnet core 2.1 for Linux

- Notes

* 


Instructions, how to use this from your workstation:

1) Download terraform, make sure its in %PATH%

2) Download git - https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe

3) Download aws cli - https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi

4) Run ‘aws configure’ to configure AWS credentials - for this example please use region "eu-north-1"

5) Create c:\source (or whatever you want) and cd into it

6) Open git bash and run ‘git clone https://github.com/glarsson/glarssonaws.git’ in /c/source

7) Create keys;
   in git bash go to /terraform/test/keys and run:
   ssh-keygen -t rsa -b 4096 -C "your_email@address.com"
   name the key "test_key" and enter a password if you'd like, the private key is in .gitignore
   do the same for /terraform/staging/keys and /terraform/production/keys, the name of the keys
   when asked by ssh-keygen is "staging_key" and "production_key", password or not is up to you.

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





