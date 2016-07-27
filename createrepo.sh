BASEURL=$1
yum install createrepo -y
cd /docker/rpm/i386
createrepo .
cd /docker/rpm/x86_64
createrepo .
