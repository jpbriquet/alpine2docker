Vagrant.configure("2") do |config|

  config.ssh.username = "alpine"
  config.ssh.shell = "bash -l"

  config.vm.provider "virtualbox" do |vm, override|

    # Custom VM configuration
    vm.customize ["modifyvm", :id, "--memory", "4096"]
    vm.customize ["modifyvm", :id, "--cpus", "2"]
    vm.customize ["modifyvm", :id, "--cableconnected1", "on"]
    vm.customize ["modifyvm", :id, "--audio", "none"]
    vm.customize ["modifyvm", :id, "--usb", "off"]

    # For secured workstations
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # VM time/date can drift between host and guest when the host goes to sleep.
    # Set the timesync threshold to 10 seconds instead of the default 20 minutes.
    # With this option virtualbox will correctly update the time
    vm.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # FS share
    config.vm.synced_folder ".", "/vagrant"
  end

end
