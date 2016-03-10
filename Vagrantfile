# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # ------------------------------
  # --- CentOS (saltmaster) host -
  # ------------------------------
  config.vm.define :saltmaster do |saltmaster_config|
    # --- Use the Virtualbox GUI ---
    saltmaster_config.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.name = "salt_admin_saltmaster"
       vb.memory = 1024
    end
    # --- Define virtual machine ---
    saltmaster_config.vm.box = "box-cutter/centos65"
    saltmaster_config.vm.box_check_update = false
    saltmaster_config.vm.host_name = "saltmaster"

    # SSH settings
    saltmaster_config.ssh.username = "root"
    saltmaster_config.ssh.password = "vagrant"
    saltmaster_config.ssh.insert_key = true
    #saltmaster_config.ssh.pty = true
    
    # Network settings
    saltmaster_config.vm.network "private_network", ip: "192.168.50.100"
    #saltmaster_config.vm.network "private_network", type: "dhcp"
    #saltmaster_config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'
    #saltmaster_config.vm.network "forwarded_port", guest: 4505, host: 4505

   # # Install Salt with custom bootstrap
   saltmaster_config.vm.provision :shell, inline: '/vagrant/provision/saltify.sh master'
  end
  #  ------------------------------
  #  --- CentOS (cweb) host ---
  #  ------------------------------
  config.vm.define :cweb do |cweb_config|
    # --- Use the Virtualbox GUI ---
    cweb_config.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.name = "salt_admin_cweb"
       #vb.memory = 515 
    end
    # --- Define virtual machine ---
    cweb_config.vm.box = "box-cutter/centos65"
    cweb_config.vm.box_check_update = false
    cweb_config.vm.host_name = "cweb"

    # SSH settings
    cweb_config.ssh.username = "root"
    cweb_config.ssh.password = "vagrant"
    cweb_config.ssh.insert_key = true
    
    # Network settings
    cweb_config.vm.network "private_network", ip: "192.168.50.101"
    
    # Install Salt with custom bootstrap
    cweb_config.vm.provision :shell, inline: '/vagrant/provision/saltify.sh minion'
  end
  #  ------------------------------
  #  --- CentOS (redis) host ---
  #  ------------------------------
  config.vm.define :redis do |redis_config|
    # --- Use the Virtualbox GUI ---
    redis_config.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.name = "salt_admin_redis"
       #vb.memory = 515 
    end
    # --- Define virtual machine ---
    redis_config.vm.box = "box-cutter/centos65"
    redis_config.vm.box_check_update = false
    redis_config.vm.host_name = "redis"

    # SSH settings
    redis_config.ssh.username = "root"
    redis_config.ssh.password = "vagrant"
    redis_config.ssh.insert_key = true
    
    # Network settings
    redis_config.vm.network "private_network", ip: "192.168.50.102"
    
    # Install Salt with custom bootstrap
    redis_config.vm.provision :shell, inline: '/vagrant/provision/saltify.sh minion'
  end
  #  ------------------------------
  #  --- Ubuntu (uarchive) host ---
  #  ------------------------------
  config.vm.define :uarchive do |uarchive_config|
    # --- Use the Virtualbox GUI ---
    uarchive_config.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.name = "salt_admin_uarchive"
       #vb.memory = 515 
    end
    # --- Define virtual machine ---
    uarchive_config.vm.box = "box-cutter/ubuntu1404"
    uarchive_config.vm.box_check_update = false
    uarchive_config.vm.host_name = "uarchive"

    # Network settings
    uarchive_config.vm.network "private_network", ip: "192.168.50.103"
    
    # Install Salt with custom bootstrap
    uarchive_config.vm.provision :shell, inline: 'sudo /vagrant/provision/saltify.sh minion'
  end
  #  ------------------------------
  #  --- SUSE (sdev) host ---
  #  Haven't found a good one yet 
  #  so using CentOS
  #  ------------------------------
  config.vm.define :sdev do |sdev_config|
    # --- Use the Virtualbox GUI ---
    sdev_config.vm.provider "virtualbox" do |vb|
       vb.gui = true
       vb.name = "salt_admin_sdev"
       #vb.memory = 515 
    end
    # --- Define virtual machine ---
    #_config.vm.box = "suse/sles11sp3"
    sdev_config.vm.box = "box-cutter/centos65"
    sdev_config.vm.box_check_update = false
    sdev_config.vm.host_name = "sdev"

    # Network settings
    sdev_config.vm.network "private_network", ip: "192.168.50.104"
    
    # Install Salt with custom bootstrap
    sdev_config.vm.provision :shell, inline: '/vagrant/provision/saltify.sh minion'
  end
end
