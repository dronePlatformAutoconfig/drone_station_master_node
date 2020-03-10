apt-get install -y ros-${ROS_DISTRO}-rosbridge-server


echo """export private_IP=\$(ifconfig  | grep -E '\s([0-9]{1,3}\.){3}[0-9]{1,3}\s' --color=no | grep  -ve '127.0.0.1' | awk -F ' ' '{print \$2}')""" >> ~/.bashrc
echo "export public_IP=\$(curl http://checkip.amazonaws.com)" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://master.private:11311" >> ~/.bashrc
echo "export ROS_HOSTNAME=master.public" >> ~/.bashrc
echo "export ROS_IP=${public_IP}" >> ~/.bashrc
source ~/.bashrc

echo "${private_IP} master.private" | sudo tee -a /etc/hosts
echo "${public_IP} master.public" | sudo tee -a /etc/hosts


# echo """export private_IP=\$(ifconfig ens5 | grep -E '\s([0-9]{1,3}\.){3}[0-9]{1,3}\s' --color=no | awk -F ' ' '{print \$2}')""" >> ~/.bashrc
# echo "export public_IP=\$(curl http://checkip.amazonaws.com)" >> ~/.bashrc
# echo "export ROS_MASTER_URI=http://master.public:11311" >> ~/.bashrc
# echo "export ROS_HOSTNAME=worker.public" >> ~/.bashrc
# echo "export ROS_IP=${public_IP}" >> ~/.bashrc
# source ~/.bashrc

# echo "${private_IP} worker.private" | sudo tee -a /etc/hosts
# echo "${public_IP} worker.public" | sudo tee -a /etc/hosts