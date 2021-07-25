#!/bin/bash

projectName=academymarquee
pluginDirectory=blocks

cd ../

COPYFILE_DISABLE=1 /usr/bin/tar \
	--exclude='./.git*' \
	--exclude='./deploy.sh' \
	--exclude='*.DS_Store' \
	-czvf $projectName.tar.gz ./$projectName
/usr/bin/scp -i "~/cnn-academy-frankfurt.pem" ./$projectName.tar.gz bitnami@ec2-3-67-111-127.eu-central-1.compute.amazonaws.com:~/

/bin/rm ./$projectName.tar.gz

/usr/bin/ssh -tt -i "~/cnn-academy-frankfurt.pem" bitnami@ec2-3-67-111-127.eu-central-1.compute.amazonaws.com << EOF
cd /tmp
cd /bitnami/moodle/$pluginDirectory
/bin/rm -rf $projectName
sudo /bin/mv ~/$projectName.tar.gz ./
sudo /bin/tar -xzvf $projectName.tar.gz
sudo /bin/rm $projectName.tar.gz
exit
EOF
