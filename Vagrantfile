Vagrant.configure("2") do |config|

	config.vm.box = "bento/ubuntu-20.04"

	config.vm.provider "virtualbox" do |vb|
		vb.customize [ "modifyvm", :id, "--uart1", "0x3F8", "4" ]
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	    vb.memory = 3048
        vb.cpus = 2
    end

    config.vm.network "private_network", ip: "192.168.33.27"
    config.vm.hostname = "crud.local"
	config.vm.boot_timeout = 600
    config.vm.synced_folder ".", "/var/www/html", :mount_options => ["dmode=777", "fmode=777"], owner: "vagrant", group: "vagrant"

    config.vm.provision :shell, path: "script.sh"

end
