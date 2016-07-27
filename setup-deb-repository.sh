#!/bin/sh -e

# GH=$1
# EMAIL=$2

REPO=`echo ${GH} | cut -d '/' -f 2`
USER=`echo ${GH} | cut -d '/' -f 1`

sudo apt-get install build-essential -y
curl -L https://raw.githubusercontent.com/mh-cbon/latest/master/install.sh | GH=mh-cbon/gh-api-cli sh -xe

git checkout --track -b origin/gh-pages || echo "branch already exists"
git config user.name "${USER}"
git config user.email "${EMAIL}"

rm -fr apt
# mkdir -p apt/binary-{i386,amd64} # huh ... it won t work ?
mkdir -p apt/binary-i386
mkdir -p apt/binary-amd64
gh-api-cli dl-assets -o ${USER} -r ${REPO} --out apt/%r-%v_%a.%e -g "*deb" --ver latest


cd apt
dpkg-scanpackages -a amd64 . /dev/null | gzip -9c > binary-amd64/Packages.gz
dpkg-scanpackages -a 386 . /dev/null | gzip -9c > binary-i386/Packages.gz

cat <<EOT > ${REPO}.list
deb [trusted=yes] https://${USER}.github.io/${REPO}/apt/ /binary-\$(ARCH)/
EOT

git add -A
git commit -m "Created debian repository"

set +x # disable debug output because that would display the token in clear text..
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH}.git" gh-pages
