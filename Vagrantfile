$script = <<SCRIPT
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install -y build-essential libtool autoconf
apt-get install -y git
apt-get install -y zlib1g-dev libssl-dev libbz2-dev
apt-get install -y libsasl2-dev libxml2-dev libsqlite3-dev
apt-get install -y libxslt1-dev python-dev python3-dev
apt-get install -y libreadline-dev
apt-get install -y nginx wget
apt-get install -y openjdk-8-jdk
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
useradd -s /bin/bash -m -G sudo backend
su -c "mkdir /home/backend/.ssh" backend
cat > /etc/sudoers.d/backend << EOF
backend ALL=(ALL) NOPASSWD:ALL
EOF
cat > /home/backend/.ssh/authorized_keys << EOF
# Added Your Publick Key for ssh login
EOF
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
  end

  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "ubuntu/xenial64"
    # Add your vboxnet0 ip
    vm1.vm.network :private_network, ip: "Add your private ip(check virtual"
    vm1.vm.provision "shell", inline: $script
  end

end
