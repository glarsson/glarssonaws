#!/bin/bash

# initial configuration for web nodes
# instances are brought up before network is available which makes yum unable to find any repos...
# depends_on feature seems to be lacking when used within modules, maybe in version 0.12 that will work

# unfortunately, going to use a dirty hack here and sleep for <a few> minutes before continuing the script

# here comes the sleeper, 5 minutes was too much, trying with 1
# it would be better to check here if for example "ping 8.8.8.8" works...
sleep 1m

# install some tools, some may not be needed in a production environment
yum -y install nano
yum -y install links
yum -y install telnet
yum -y install wget
yum -y install nc

# install dotnet core
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

# ugly hack to check which environment/database endpoint to connect to
#
#if nc -z database-endpoint.test.glarssonaws.local 3306 2>/dev/null; then
#    database_endpoint="database-endpoint.test.glarssonaws.local"
#fi
#
#if nc -z database-endpoint.staging.glarssonaws.local 3306 2>/dev/null; then
#    database_endpoint="database-endpoint.staging.glarssonaws.local"
#fi
#
#if nc -z database-endpoint.production.glarssonaws.local 3306 2>/dev/null; then
#    database_endpoint="database-endpoint.production.glarssonaws.local"
#fi

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

dotnet ef migrations add InitialCreate
dotnet ef database update

# finally run the application, it runs HTTP on port 5000
dotnet run
EOF

# back to root


