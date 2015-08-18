Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/trusty64"
    web.vm.hostname = "web.example.com"
    web.vm.network "private_network", ip: "192.168.100.2"
    web.vm.provision "puppet"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/trusty64"
    db.vm.hostname = "db.example.com"
    db.vm.network "private_network", ip: "192.168.100.3"
    db.vm.provision :shell, :path => "install_puppet_modules.sh"
    db.vm.provision "puppet"
  end
end
