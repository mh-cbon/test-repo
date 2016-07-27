BASEURL=$1

cat <<EOT
deb ${BASEURL} /binary-\$(ARCH)/
EOT
