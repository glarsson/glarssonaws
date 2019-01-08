#!/bin/bash

# set hostname
hostnamectl set-hostname --static ${terraform_hostname}
echo 'preserve_hostname: true' | tee -a /etc/cloud/cloud.cfg

# install and configure dns forwarder
yum -y install bind bind-utils
cat >/etc/named.conf <<EOM
acl "trusted" {
              any;
};
options {
                directory "/etc/named";
                recursion yes;
                allow-query { trusted; };
                forwarders {
                            10.0.0.2;
                };
                forward only;
                dnssec-enable no;
                dnssec-validation no;
                dnssec-lookaside auto;
                auth-nxdomain no;
                listen-on { any; };
};
EOM

# enable the service and start it
systemctl enable named
systemctl start named


