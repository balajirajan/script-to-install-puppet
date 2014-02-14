#!/bin/bash

#Script to install Puppet and its dependencies  #


# Download apache and necessary dependencies
yum install -y httpd httpd-devel mod_ssl ruby-devel rubygems gcc-c++ curl-devel zlib-devel make automake
 

### Installing Ruby
echo "Installing Ruby......."
yum -y -e 0 -d 0 install ruby ruby-devel rubygems libselinux-ruby gcc make
gem install -r ruby-shadow
 
echo "Downloading Facter............"
curl -s -O http://downloads.puppetlabs.com/facter/facter-latest.tgz
 
echo "Downloading Puppet......."
curl -s -O http://downloads.puppetlabs.com/puppet/puppet-latest.tar.gz
 
id puppet 2>1 1>/dev/null
if [[ $? == 1 ]]; then
  adduser -r puppet
fi
 

## Install Facter   ##Facter is an independent, cross-platform Ruby library designed to gather information on
all the nodes you will be managing with Puppet.##

echo "Installing Facter.."
tar xzf facter-latest.tgz
rm -f facter-latest.tgz
pushd facter*
ruby ./install.rb 1>/dev/null

 
 
## Install Puppet

echo "Installing Puppet.."
tar xzf puppet-latest.tar.gz
rm -f puppet-latest.tar.gz
pushd puppet*
ruby ./install.rb 1>/dev/null
 
cp conf/redhat/client.init /etc/init.d/puppet && chmod +x /etc/init.d/puppet
cp conf/redhat/client.sysconfig /etc/sysconfig/puppet
cp conf/redhat/logrotate /etc/logrotate.d/puppetmaster
cp conf/redhat/puppet.conf /etc/puppet/
chkconfig --add puppet
chkconfig puppet on
exit
