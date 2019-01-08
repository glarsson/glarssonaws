#!/bin/bash

# install some tools
yum -y install nano
yum -y install links
yum -y install telnet
yum -y install wget
yum -y install nc
yum -y install bind-utils

# set hostname
hostnamectl set-hostname --static ${terraform_hostname}
echo 'preserve_hostname: true' | tee -a /etc/cloud/cloud.cfg

# add route53 DNS server
# dig +short ${route53_name_server} >> /etc/resolv.conf

# install git and dotnet core
yum -y install git
yum -y install centos-release-dotnet
yum -y install rh-dotnet21

# not needed for init script
#scl enable rh-dotnet21 bash

adduser dotnet

# switch to dotnet user and build/start application
sudo -u dotnet bash << EOF

# setup paths
export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/dotnet/.local/bin:/home/dotnet/bin:/opt/rh/rh-dotnet21/root/usr/bin:/home/dotnet/.dotnet/tools"

cd /home/dotnet
mkdir app
cd app
git clone https://github.com/glarsson/glarssonaws.git
cd glarssonaws
rm -rf README.md terraform

# create the appsettings.json file

cat >/home/dotnet/app/glarssonaws/dotnet_core_application/dotnet_core_application/appsettings.json <<EOM
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
  "DefaultConnection": "server=${database_endpoint};userid=root;password=${rds_master_password};database=glarssonaws_db;"
  }
}
EOM

cd /home/dotnet/app/glarssonaws/dotnet_core_application/dotnet_core_application

# compile the application
# $HOME needs to be defined or dotnet core doesn't work, so we make sure before building and running
export HOME="/home/dotnet"

dotnet build

# install dotnet-ef and create the database
dotnet tool install --global dotnet-ef --version 2.1.1

# quick hack to make sure only one web node creates the database
if hostname -f | grep web-1 2>/dev/null; then
  dotnet ef migrations add InitialCreate
  dotnet ef database update
fi

# finally run the application, it runs HTTP on port 5000
dotnet run
EOF

# back to root


