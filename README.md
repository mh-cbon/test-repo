# tests

Let s see.


```sh
wget -O yum/changelog-0.0.20-1-386.rpm https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-386.rpm
wget -O yum/changelog-0.0.20-1-amd64.rpm https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-amd64.rpm
wget -O yum/changelog-0.0.18-1-386.rpm https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-386.rpm
wget -O yum/changelog-0.0.18-1-amd64.rpm https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-amd64.rpm
vagrant up
vagrant ssh -c 'sudo yum install createrepo -y'
vagrant ssh -c 'cd /vagrant/yum && createrepo --database `pwd`'
vagrant ssh -c 'cd /vagrant/yum && createrepo . -s sha256 -u http://github.com/mh-cbon/test-repo/blob/master/yum/ -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-amd64.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-amd64.rpm'
```
