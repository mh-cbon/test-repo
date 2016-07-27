BASEURL=$1
sudo yum install createrepo -y
cd /docker/yum/i386
createrepo . --no-database -u $BASEURL/i386/ -i ../../i386.list
cd /docker/yum/amd64
createrepo . --no-database -u $BASEURL/amd64/ -i ../../amd64.list
