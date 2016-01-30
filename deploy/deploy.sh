#!/bin/sh

HOSTNAME=$1
SALTMODE=""
PASSWORD=$3

if [ -z "${HOSTNAME}" ];
then
	echo "Missing first argument HOSTNAME"
	exit 1
fi
if [ X"$2" = X"master" ] ;
then
	SALTMODE="salt-master"
fi
if [ X"$2" = X"minion" ] ;
then
	SALTMODE="salt-minion"
fi
if [ X"$2" = X"mm" ] ;
then
	SALTMODE="salt-master salt-minion"
fi
if [ -z "${SALTMODE}" ];
then
	echo "Missing second argument SALTMODE [master|minion|mm]"
	exit 1
fi
if [ -z "${PASSWORD}" ];
then
	echo "Missing password for user manuel"
	exit 1
fi

# Clean up
rm -r firstboot_done && rm firstboot.sh

# Update repos
sudo apt-get update

# Setup Hostname
echo "Settint hostname ${HOSTNAME}"
sudo echo ${HOSTNAME} > /etc/hostname 
sudo sed -i 's/black-pearl/${HOSTNAME}/g' /etc/hosts
sudo /etc/init.d/hostname.sh start

# Setup a user
echo "Setup usr manuel:rootbig456"
sudo useradd -m -s /bin/bash manuel
echo manuel:${PASSWORD} | sudo chpasswd
echo 'manuel ALL=(ALL) ALL' >> /etc/sudoers
sudo cp /root/.bashrc /home/manuel/
sudo cp /root/.profile /home/manuel/
sudo cp /root/.bash_prompt /home/manuel/
sudo chown -R manuel /home/manuel/

# Disable ssh root login
echo "Disable ssh root login"
sudo sed -i 's/PermitRootLogin\ yes/PermitRootLogin\ no/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

# Install compiler stuff
sudo apt-get install -y build-essential python-dev

# Setup salt
echo "Setup salt-minion ${SALTMODE}"
# Install stable salt from the base system with all dependencies
echo "deb http://debian.saltstack.com/debian jessie-saltstack main" >> /etc/apt/sources.list
wget -O - http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key|apt-key add -
sudo apt-get install -y ${SALTMODE}
if [ X"${SALTMODE}" != X"salt-master" ] ;
then
	echo "Setting minion name: ${HOSTNAME}"
	sed -i "s/#id:/id:\ ${HOSTNAME}/g" /etc/salt/minion
fi

# Install stable salt from pypi and update dependencies using pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py 
sudo pip install --install-option="--jobs=4" salt --upgrade

if [ X"${SALTMODE}" = X"salt-master" ] ;
then
	sudo /etc/init.d/salt-master restartsudo apt-get install -y ${SALTMODE}
	exit 0
fi

sudo /etc/init.d/salt-minion restart

echo "done"


# Configure services autostart
# update-rc.d -f servicename [stop]remove
# update-rc.d servicename defaults


