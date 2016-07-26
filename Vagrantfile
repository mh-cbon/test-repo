
Vagrant.configure("2") do |config|

    config.vm.box = "centos/7"
    config.vm.synced_folder ".", "/vagrant"
    config.vm.provider :virtualbox do |vb|
      vb.gui = false
    end
end
