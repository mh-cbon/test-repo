# tests

Let s see.


```sh
git branch gh-pages
git checkout gh-pages
vagrant up
vagrant ssh -c 'sudo yum install createrepo -y'
vagrant ssh -c 'cd /vagrant/yum && createrepo --database `pwd`'
vagrant ssh -c 'cd /vagrant/yum && createrepo . --no-database -u https://mh-cbon.github.io/test-repo/yum/ -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.20/changelog-amd64.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-386.rpm -n https://github.com/mh-cbon/changelog/releases/download/0.0.18/changelog-amd64.rpm'
git add -A
git commit -am 'init test repo rpm'
git push --all
```
