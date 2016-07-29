#!/bin/sh -xe

# GH=$1

REPO=`echo ${GH} | cut -d '/' -f 2`
USER=`echo ${GH} | cut -d '/' -f 1`

if [ ! -d "aptly_0.9.7_linux_amd64" ]; then
  wget https://bintray.com/artifact/download/smira/aptly/aptly_0.9.7_linux_amd64.tar.gz
  tar xzf aptly_0.9.7_linux_amd64.tar.gz
  PATH=$PATH:`pwd`/aptly_0.9.7_linux_amd64/
fi

if type "gh-api-cli" > /dev/null; then
  echo "gh-api-cli already installed"
else
  wget -q -O - --no-check-certificate \
  https://raw.githubusercontent.com/mh-cbon/latest/master/install.sh \
  | GH=mh-cbon/gh-api-cli sh -xe
fi

cat <<EOT > aptly.conf
{
  "rootDir": "`pwd`/apt",
  "downloadConcurrency": 4,
  "downloadSpeedLimit": 0,
  "architectures": [],
  "dependencyFollowSuggests": false,
  "dependencyFollowRecommends": false,
  "dependencyFollowAllVariants": false,
  "dependencyFollowSource": false,
  "gpgDisableSign": true,
  "gpgDisableVerify": true,
  "downloadSourcePackages": false,
  "ppaDistributorID": "",
  "ppaCodename": ""
}
EOT

if [ ! -d "repo" ]; then
  gh-api-cli dl-assets -o ${USER} -r ${REPO} -g '*deb' -out 'pkg/%r-%v_%a.deb' --ver '<2.0.0'

  mkdir apt
  cd apt
  aptly repo create -config=../aptly.conf -distribution=all -component=main ${REPO}
  aptly repo add -config=../aptly.conf ${REPO} ../pkg
  aptly publish -component=contrib -config=../aptly.conf repo ${REPO}
  aptly repo show -config=../aptly.conf -with-packages ${REPO}

else
  gh-api-cli dl-assets -o ${USER} -r ${REPO} -g '*deb' -out 'pkg/%r-%v_%a.deb' --ver '>=2.0.0'

  cd apt
  aptly repo add -config=../aptly.conf ${REPO} ../pkg
  aptly publish -config=../aptly.conf update all
  aptly repo show -config=../aptly.conf -with-packages ${REPO}
fi


cat <<EOT > ${REPO}.list
deb [trusted=yes] https://${USER}.github.io/${REPO}/apt/ all contrib
EOT

rm -f aptly_0.9.7_linux_amd64.tar.gz aptly.conf
rm -fr aptly_0.9.7_linux_amd64 pkg
