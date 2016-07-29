# tests

Let s see.


```sh
travis encrypt --add -r mh-cbon/test-repo GH_TOKEN=...

git branch gh-pages
git checkout gh-pages
mkdir yum
vagrant up rh
vagrant ssh -c 'sudo yum install createrepo -y' rh
vagrant ssh -c 'cd /vagrant/yum && createrepo --database `pwd`' rh
vagrant ssh -c 'cd /vagrant/yum && createrepo . --no-database -u https://mh-cbon.github.io/test-repo/yum/ -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-amd64.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-amd64.rpm' rh
git add -A
git commit -am 'init test repo rpm'
git push --all
vagrant ssh -c 'sudo sh -c "curl https://mh-cbon.github.io/test-repo/rpm/changelog.repo > /etc/yum/repos.d/changelog.repo"' rh
vagrant ssh -c 'which changelog' rh
```

```sh
vagrant up deb
vagrant ssh -c 'sudo apt-get install build-essential -y' deb
wget -O apt/changelog-0.0.20_386.deb https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-386.deb
wget -O apt/changelog-0.0.20_amd64.deb https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-amd64.deb
wget -O apt/changelog-0.0.18_386.deb https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-386.deb
wget -O apt/changelog-0.0.18_amd64.deb https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-amd64.deb
vagrant ssh -c 'cd /vagrant/apt && dpkg-scanpackages -a amd64 . /dev/null | gzip -9c > binary-amd64/Packages.gz' deb
vagrant ssh -c 'cd /vagrant/apt && dpkg-scanpackages -a 386 . /dev/null | gzip -9c > binary-i386/Packages.gz' deb
vagrant ssh -c 'sudo wget -O /etc/apt/sources.list.d/changelog.list https://mh-cbon.github.io/test-repo/apt/changelog.list' deb
vagrant ssh -c 'cat /etc/apt/sources.list.d/changelog.list' deb
vagrant ssh -c 'sudo apt-get install apt-transport-https -y' deb
vagrant ssh -c 'sudo apt-get update' deb
vagrant ssh -c 'apt-cache search changelog' deb
vagrant ssh -c 'sudo apt-get install changelog -y' deb
vagrant ssh -c 'which changelog' deb
```

```sh
vagrant up deb
vagrant ssh -c 'cd /vagrant && GH=mh-cbon/gh-api-cli sh aptly.sh' deb
vagrant ssh -c 'cd /vagrant/aptly && aptly repo show -config=../aptly.conf -with-packages gh-api-cli' deb
```

see also
https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db#.xp456ouyo
