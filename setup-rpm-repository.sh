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


rm -fr rpm
mkdir -p rpm/{i386,x86_64}
gh-api-cli dl-assets -o ${USER} -r ${REPO} --out rpm/i386/%r-%v_%a.%e -g "*386*rpm"
gh-api-cli dl-assets -o ${USER} -r ${REPO} --out rpm/x86_64/%r-%v_%a.%e -g "*amd64*rpm"

DESC=`rpm -qip *.rpm | grep Summary | cut -d ':' -f2 | cut -d ' ' -f2- | tail -n 1`

cat <<EOT > createrepo.sh
yum install createrepo -y
cd /docker/rpm/i386
createrepo .
cd /docker/rpm/x86_64
createrepo .
EOT
docker run -v $PWD:/docker fedora /bin/sh -c "cd /docker && sh ./createrepo.sh"


cat <<EOT > rpm/${REPO}.repo
[${REPO}]
name=${DESC}
baseurl=https://${USER}.github.io/${REPO}/rpm/\$basearch/
enabled=1
skip_if_unavailable=1
gpgcheck=0
EOT


git add -A
git commit -m "Created rpm repository"

set +x # disable debug output because that would display the token in clear text..
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH}.git" gh-pages 2> /dev/null || echo "!!!! gh-pages branch could not be uploaded to your remote" && exit 1
