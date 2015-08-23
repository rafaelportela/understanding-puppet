mkdir -p /etc/puppet/modules
sudo apt-get update

MYSQL_INSTALLED=`puppet module list | grep mysql`

# if MYSQL_INSTALLED == '' or empty
if [ -z "$MYSQL_INSTALLED" ]
then
  echo "Installing puppetlabs/mysql module"
  puppet module install puppetlabs/mysql
else
  echo "puppetlabs/mysql already installed"
fi
