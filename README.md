glarssonaws

An example of how to bring up a HA (highly available) dotnet core application
on AWS using, in this example, CentOS, AWS ELB, Aurora Cluster and dotnet core 2.1 for Linux

Scroll down for instructions how to bring this up.

TODO:

* need to make sure 'dotnet' process retarts if it crashes, or alternatively bring up
  new web instances if load balancer notices number of webnodes is under threshold for a period of time












Instructions, how to use this from your workstation (assuming you're running Windows):

1) Download terraform (https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip), make sure its in %PATH%

2) Download git - https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe

3) Download AWS CLI - https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi

4) Run ‘aws configure’ to configure AWS credentials - for this example please use region "eu-north-1" (doesn't really matter though but thats the region that's targeted here)

5) Create c:\source (or whatever you want)

6) Open git bash, go to /c/source/ and run ‘git clone https://github.com/glarsson/glarssonaws.git’

7) Create keys;
   in git bash go to /c/source/glarssonaws/terraform/test/keys and run:
   ssh-keygen -t rsa -b 4096 -C "your_email@address.com"
   name the key "test_key" and enter a password if you'd like, the private key is in .gitignore
   do the same for /c/source/glarssonaws/terraform/staging/keys and 
   /c/source/glarssonaws/terraform/production/keys, the name of the keys when asked by ssh-keygen
   is "test_key", "staging_key" and "production_key", password or not is up to you.

8) In each terraform environment, create "secret_variables.tf";

   c:\source\glarssonaws\terraform\test\secret_variables.tf

   c:\source\glarssonaws\terraform\staging\secret_variables.tf

   c:\source\glarssonaws\terraform\production\secret_variables.tf

   conents of that file:

   variable "rds_master_username" {

   default = "whatever_username_you_want"

   }

   variable "rds_master_password" {

   default = "whatever_password_you_want"
   
   }


TO BRING UP TEST, use powershell instead of git bash;
1) go to c:\source\glarssonaws\terraform\test
2) run command "terraform init" and make sure it downloads the prerequisites.
3) run command "terraform validate" to make sure syntax is alright, may be overkill but its nice to verify
4) run command "terraform plan" to prepare terraform to take action
5) finally run command "terraform apply" and make sure you answer "yes" if you agree with the changes it proposes

TO BRING UP STAGING, use powershell instead of git bash;
1) go to c:\source\glarssonaws\terraform\staging
2) run command "terraform init" and make sure it downloads the prerequisites.
3) run command "terraform validate" to make sure syntax is alright, may be overkill but its nice to verify
4) run command "terraform plan" to prepare terraform to take action
5) finally run command "terraform apply" and make sure you answer "yes" if you agree with the changes it proposes

TO BRING UP PRODUCTION, use powershell instead of git bash;
1) same procedure will apply here but production environment isn't built yet, so TODO.





