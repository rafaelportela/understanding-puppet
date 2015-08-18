Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules; sudo apt-get update; puppet module install --force puppetlabs/mysql;"
  end

  config.vm.provision "puppet"

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/trusty64"
    web.vm.hostname = "web.example.com"
    web.vm.network "private_network", ip: "192.168.100.2"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/trusty64"
    db.vm.hostname = "db.example.com"
    db.vm.network "private_network", ip: "192.168.100.3"
  end
end
