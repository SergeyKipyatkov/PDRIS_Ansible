# -*- mode: ruby -*-
# vi: set ft=ruby :

def form_ips(is_home = "false", num = 0)
    @is_home = is_home.to_s.downcase == "true"
    @header = "10.211."
    if @is_home
      return "192.168.56.%d" % [100 + num]
    else
        @suffix = Etc.getlogin[-3..-1].to_i * 3
        return "%s%d.%d" % [@header, @suffix / 256, @suffix % 256 - num]
    end
end

@ip1 = form_ips ENV['IS_HOME'], 7
# @ip2 = form_ips ENV['IS_HOME'], 8
puts "This script will start these VMs:"
puts "%s-node1 with IP %s" % [Etc.getlogin, @ip1]
# puts "%s-node2 with IP %s" % [Etc.getlogin, @ip2]

$enable_pass_auth_ubuntu=<<SCRIPT
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service ssh restart
SCRIPT

Vagrant.configure("2") do |config|
  config.hostmanager.enabled = false
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true
  config.hostmanager.ignore_private_ip = false
  config.ssh.forward_agent = true
  
  config.vm.synced_folder '.', '/vagrant', disabled: true

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  config.vm.define :node1 do |node1|
    node1.vm.box = "ubuntu/focal64"
    node1.vm.provider "virtualbox" do |vb|
      vb.cpus = '1'
      vb.memory = "1024"
    end
    node1.vm.network :private_network, ip: @ip1
    node1.vm.hostname = Etc.getlogin + '-node1'
    node1.vm.provision :hostmanager
  end

#  config.vm.define :node2 do |node2|
#    node2.vm.box = "ubuntu/jammy64"
#    node2.vm.provider "virtualbox" do |vb|
#      vb.cpus = '1'
#      vb.memory = "256"
#    end
#    node2.vm.network :private_network, ip: @ip2
#    node2.vm.hostname = Etc.getlogin + '-node2'
#    node2.vm.provision :hostmanager
#  end


end
