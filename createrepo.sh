BASEURL=$1
yum install createrepo -y
cd /docker/yum/i386
createrepo . --no-database -u ${BASEURL}i386/ -i ../../i386.list
cd /docker/yum/amd64
createrepo . --no-database -u ${BASEURL}x86_64/ -i ../../x86_64.list
