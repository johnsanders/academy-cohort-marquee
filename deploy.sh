#!/bin/bash

cd ../

/usr/bin/tar \
	--exclude='./.git*' \
	--exclude='./deploy.sh' \
	--exclude='*.DS_Store' \
	-czvf cohort_marquee.tar.gz ./cohort_marquee
/usr/bin/scp -i "~/cnn-academy-frankfurt.pem" ./cohort_marquee.tar.gz bitnami@ec2-3-67-111-127.eu-central-1.compute.amazonaws.com:~/

/bin/rm ./cohort_marquee.tar.gz

/usr/bin/ssh -tt -i "~/cnn-academy-frankfurt.pem" bitnami@ec2-3-67-111-127.eu-central-1.compute.amazonaws.com << EOF
cd /tmp
cd /bitnami/moodle/blocks
/bin/rm -rf cohort_marquee
sudo /bin/mv ~/cohort_marquee.tar.gz ./
sudo /bin/tar -xzvf cohort_marquee.tar.gz
sudo /bin/rm cohort_marquee.tar.gz
exit
EOF
