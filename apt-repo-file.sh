BASEURL=$2

cat <<EOT
deb ${BASEURL} /binary-$(ARCH)/
EOT
