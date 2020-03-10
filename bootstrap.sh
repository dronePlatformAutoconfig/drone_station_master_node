apt-get install -y python3-pip
apt-get  install -y awscli 
apt-get install -y cron
systemctl enable cron

echo "export S3_BUCKET=drone-station-config" >> ~/.bashrc
source ~/.bashrc
