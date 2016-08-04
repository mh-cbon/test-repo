
Vagrant.configure("2") do |config|

  config.vm.define "rh" do |rh|
    rh.vm.box = "centos/7"
    rh.vm.synced_folder ".", "/vagrant"
  end

  config.vm.define "deb" do |deb|
    deb.vm.box = "debian/jessie64"
    deb.vm.synced_folder ".", "/vagrant", type: "rsync"
    deb.vm.network "forwarded_port", guest: 4000, host: 8080
  end

  config.vm.define "win" do |win|
    win.vm.box = "opentable/win-2012r2-standard-amd64-nocm"
    # big timeout since windows boot is very slow
    win.vm.boot_timeout = 500
    win.vm.communicator = :winrm
    win.vm.provider "virtualbox" do |vb|
      # first setup requires gui to be enabled so scripts can be executed in virtualbox guest screen
      vb.gui = false
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--vram", "128"]
      vb.customize ["modifyvm", :id,  "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
    end
end

end
