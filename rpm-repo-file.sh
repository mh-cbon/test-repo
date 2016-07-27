NAME=$1
BASEURL=$2
DESC=$3

cat <<EOT
[${NAME}]
name=${DESC}
baseurl=${BASEURL}
enabled=1
skip_if_unavailable=1
gpgcheck=0
EOT
