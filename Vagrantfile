
Vagrant.configure("2") do |config|

  config.vm.define "rh" do |rh|
    rh.vm.box = "centos/7"
    rh.vm.synced_folder ".", "/vagrant"
  end

  config.vm.define "deb" do |deb|
    deb.vm.box = "debian/jessie64"
    deb.vm.synced_folder ".", "/vagrant", type: "rsync"
  end

end
