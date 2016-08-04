# tests

Let s see.

### rm repo

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


### deb repo

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

```sh
vagrant up deb
vagrant ssh -c 'wget -O - https://raw.githubusercontent.com/mh-cbon/latest/master/source.sh?cg=dfgcc | GH=mh-cbon/gh-api-cli sh -xe' deb
vagrant ssh -c 'gh-api-cli -h' deb
```


### gh-pages update

```sh
vagrant up deb
vagrant ssh -c "sudo apt-get install nodejs git ruby ruby-dev curl -y" deb
vagrant ssh -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3" deb
vagrant ssh -c "curl -sSL https://get.rvm.io | bash -s stable --ruby" deb
vagrant ssh -c "source /home/vagrant/.rvm/scripts/rvm" deb
vagrant ssh -c "gem -v" deb
vagrant ssh -c "jekyll -v" deb
vagrant ssh -c "ls -alh" deb
vagrant ssh -c "gem install bundler jekyll" deb
vagrant ssh -c "cd ~ && git clone https://github.com/pietromenna/jekyll-cayman-theme.git" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && ls -alh" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && rm -fr _posts/*" deb
vagrant ssh -c "cp /vagrant/README.md ~/jekyll-cayman-theme/index.md && cd ~/jekyll-cayman-theme" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && sh /vagrant/prepend.sh" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && sh /vagrant/config.yml.sh" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && bundle install" deb
vagrant ssh -c "cat ~/jekyll-cayman-theme/index.md" deb
vagrant ssh -c "cat ~/jekyll-cayman-theme/_config.yml" deb
vagrant ssh -c "cat ~/jekyll-cayman-theme/_includes/page-header.html" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme && jekyll serve --host=0.0.0.0" deb
vagrant ssh -c "cd ~/jekyll-cayman-theme" deb
vagrant ssh -c "git checkout -b gh-pages" deb
```

```sh
vagrant up deb
vagrant ssh -c "sudo apt-get install nodejs git ruby ruby-dev curl -y" deb
vagrant ssh -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3" deb
vagrant ssh -c "curl -sSL https://get.rvm.io | bash -s stable --ruby" deb
vagrant ssh -c "source /home/vagrant/.rvm/scripts/rvm" deb
vagrant ssh -c "gem install bundler jekyll" deb
vagrant ssh -c "cd /vagrant/ && git reset --hard HEAD && git checkout master" deb
vagrant ssh -c "cd /vagrant/ && GH=mh-cbon/test-repo JEKYLL=pietromenna/jekyll-cayman-theme sh update-ghpages.sh" deb
```

see also
https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db#.xp456ouyo
