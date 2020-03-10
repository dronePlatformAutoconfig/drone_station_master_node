if [ "$#" -ne 1 ]

then
  echo "Expected 1 argument: node_name"
  exit 1
fi

node_name=$1
private_IP=$(ifconfig  | grep -E '\s([0-9]{1,3}\.){3}[0-9]{1,3}\s' --color=no | grep  -ve '127.0.0.1' | awk -F ' ' '{print $2}')
public_IP=$(curl -s http://checkip.amazonaws.com)

hostfile=$node_name.host

# Remove temporary file if it exists
if [ -f "/tmp/$hostfile" ]; then
	rm /tmp/$hostfile
fi

# If file exists make a copy to find diff
if [ -f "$hostfile" ]; then
    cp $hostfile /tmp
fi

# Create a new file
cat /dev/null > $hostfile
echo "$node_name.private $private_IP" >> $hostfile
echo "$node_name.public $public_IP" >> $hostfile

upload() {
	aws s3 cp $(pwd)/$hostfile s3://${S3_BUCKET}/config
}

if [ -f "/tmp/$hostfile" ]; then
	if [ "$(diff $hostfile /tmp/$hostfile | wc -l)" -ne "0" ]; then
		# Difference has been found, upload new version
		upload
	fi;
else
	# Initial upload, $hostfile was created for the first time
	upload
fi