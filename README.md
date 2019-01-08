### An example of how to bring up a highly available dotnet core application on AWS using - in this example; Terraform, CentOS 7, AWS ELB, AWS EC2, AWS Aurora Cluster (mysql) and dotnet core 2.1 for Linux

#### Instructions how to deploy this from your Windows workstation
1. Download terraform (https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip), make sure its in %PATH%
2. Download git - https://github.com/git-for-windows/git/releases/download/v2.20.1.windows.1/Git-2.20.1-64-bit.exe
3. Download AWS CLI - https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi
4. Run ‘aws configure’ to configure AWS credentials - in this example we use "us-east-1" but it is "hardcoded" in terraform
5. Create c:\source (or whatever you want)
6. Open git bash, go to /c/source/ and run ‘git clone https://github.com/glarsson/glarssonaws.git’
7. Create keys; in git bash create the ssh keys for the environments in the following directories:
   ```
   /c/source/glarssonaws/terraform/test/keys/
   /c/source/glarssonaws/terraform/staging/keys/
   /c/source/glarssonaws/terraform/production/keys/
   to create key run command in git bash: ssh-keygen -t rsa -b 4096 -C "your_email@address.com"
   name the key "ENVIRONMENT_key" - so for each it will be "test_key", "staging_key" and "production_key".
   ```
8. In each terraform environment, create "secret_variables.tf", this file will contain the username and password for your aurora cluster root user:
   ```
   c:\source\glarssonaws\terraform\test\secret_variables.tf
   c:\source\glarssonaws\terraform\staging\secret_variables.tf
   c:\source\glarssonaws\terraform\production\secret_variables.tf
   contents of that file:
   
   variable "rds_master_username" {
     default = "whatever_username_you_want"
   }
   variable "rds_master_password" {
     default = "whatever_password_you_want"
   }
   ```
9. If you want to debug/run/develop the dotnet core application locally you need to add "appsettings.json" in glarssonaws/dotnet_core_application/dotnet_core_application/ - of course you need a local mysql server for this..
   ```
   {
     "Logging": {
       "LogLevel": {
         "Default": "Warning"
       }
     },
     "AllowedHosts": "*",
     "ConnectionStrings": {
       "DefaultConnection": "server=MYSQL_SERVER;userid=MYSQL_USERNAME;password=MYSQL_PASSWORD;database=glarssonaws_db;"
     }
   }
   ```

#### To bring up test
1. Go to c:\source\glarssonaws\terraform\test
2. Run command "terraform init"
3. Run command "terraform plan" to prepare terraform to take action
4. Finally run command "terraform apply" and make sure you answer "yes" if you agree with the changes it proposes
   
#### To bring up staging
1. Go to c:\source\glarssonaws\terraform\staging
2. Run command "terraform init"
3. Run command "terraform plan" to prepare terraform to take action
4. Finally run command "terraform apply" and make sure you answer "yes" if you agree with the changes it proposes
   
#### To bring up production
1. Production doesn't exist, you can look at staging as the same as production. It was not developed here because of cost-saving reasons. Every time these instances are brought up there is a cost.
